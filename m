Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07081C3A5A6
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 02:30:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBC5E2196E
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 02:30:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405695AbfITCaZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 22:30:25 -0400
Received: from gate.crashing.org ([63.228.1.57]:59497 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405325AbfITCaY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 22:30:24 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id x8K2RJ7O003665;
        Thu, 19 Sep 2019 21:27:20 -0500
Message-ID: <f574fddf9b55884a168e186390018fbc32c776b2.camel@kernel.crashing.org>
Subject: Re: [tech-privileged] [RFC PATCH V1] riscv-privileged: Add
 broadcast mode to sfence.vma
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     Andrew Waterman <andrew@sifive.com>, Guo Ren <guoren@kernel.org>
Cc:     Anup.Patel@wdc.com, Atish.Patra@wdc.com,
        Guo Ren <ren_guo@c-sky.com>, catalin.marinas@arm.com,
        dwmw2@infradead.org, feiteng_li@c-sky.com, gary@garyguo.net,
        iommu@lists.linux-foundation.org, jacob.jun.pan@linux.intel.com,
        jean-philippe@linaro.org, julien.grall@arm.com,
        julien.thierry@arm.com, kvmarm@lists.cs.columbia.edu,
        linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        marc.zyngier@arm.com, palmer@sifive.com, rppt@linux.ibm.com,
        tech-privileged@lists.riscv.org, will.deacon@arm.com
Date:   Fri, 20 Sep 2019 12:27:19 +1000
In-Reply-To: <CA++6G0AzDs7w3gjjT4tDZjWBiMPf4Bvd36Ak0xdzfcJdPriKiw@mail.gmail.com>
References: <1568896556-28769-1-git-send-email-guoren@kernel.org>
         <CA++6G0AzDs7w3gjjT4tDZjWBiMPf4Bvd36Ak0xdzfcJdPriKiw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-09-19 at 09:04 -0700, Andrew Waterman wrote:
> This needs to be discussed and debated at length; proposing edits to
> the spec at this stage is putting the cart before the horse!
> 
> We shouldn’t change the definition of the existing SFENCE.VMA
> instruction to accomplish this. It’s also not abundantly clear to me
> that this should be an instruction: TLB shootdown looks more like
> MMIO.

Quite a few points to make here:

 - TLB shootdown as MMIO is a problem when you start trying to do it
directly from guests (which is very desirable). I can elaborate if you
want, but it generally boils down to having a pile of copies of the
MMIO resources to assign to guests and having to constantly change
mappings which is unrealistic.

 - I generally have very serious doubts as to the value of doing
broadcast TLB shootdowns in HW. I went at lenght about it during Linux
Plumbers Conference, but I'll try to summarise here, from my experience
back at IBM working on POWER. In no special order:

   * It doesn't scale well. You have to drain all the target CPU queues
of already translated load stores, keep ordering, etc... it causes a
giant fabric traffic jam. Experience has shown that on some POWER
systems, it becomes extremely expensive.

   * Some OS such as Linux track which CPU has seen a given context.
That allows to "target" TLB invalidations in a more sensible way.
Broadcast instructions tend to lose that ability (it's hard to do in HW
esp. in a way that can be virtualized properly).

   * Because those instructions can take a very long time (for the
above reasons and some of below ones), or at least whatever context
synchronizing instruction that follow which waits for completion of the
invalidations, you end up with a CPU effectively "stuck" for a long
time, not taking interrupts, including those routed to higher priority
levels (ie. hypervisor etc...). This is problematic. A completion
polling mechanism is preferable so that once can still handle such work
while waiting but is hard to architect/implement properly when done as
"instructions" since they can happen concurrently from multiple
contexts. It's easier with MMIO but that has other issues.

   * It introduces races with anything that does SW walk of page
tables. For example MMIO emulation by a hypervisor cannot be done race-
free if the guest can do its own broadcast invalidations and the
hypervisor has to walk the guest page tables to translate. I can
elaborate if requested.

   * Those invalidations need to also target nest agents that can hold
translations, such as IOMMUs that can operate in usr contexts etc...
Such IOMMUs can take a VERY LONG time to process invalidations,
especially if translations have been checked out by devices such as
PCIe devices using ATS. Some GPUs for example can hit a worst case of
hundreds of *milliseconds* to process a TLB invalidation.

 - Now for the proposed scheme. I really don't like introducing a *new*
way of tagging an address space using the PPN. It's a hack. The right
way is to ensure that the existing context tags are big enough to not
require re-use and thus can be treated as global context tags by the
hypervisor and OS. IE. have big enough VMIDs and ASIDs that each
running VM can have a global stable VMID and each process within a
given VM can have a global (within that VM) ASID instead of playing
reallocation of ASID tricks at context switch (that's very inefficient
anyway, so that should be fixed for anything that claims performance
and scalability).

Now all of these things can probably have solutions but experience
doesn't seem to indicate that it's really worthwhile. We are better off
making sure we have a really fast IPI path to perform those via
interrupts and locally to the targetted CPUs IMHO.

Cheers,
Ben.

> 
> On Thu, Sep 19, 2019 at 5:36 AM Guo Ren <guoren@kernel.org> wrote:
> > From: Guo Ren <ren_guo@c-sky.com>
> > 
> > The patch is for https://github.com/riscv/riscv-isa-manual
> > 
> > The proposal has been talked in LPC-2019 RISC-V MC ref [1]. Here is
> > the
> > formal patch.
> > 
> > Introduction
> > ============
> > 
> > Using the Hardware TLB broadcast invalidation instruction to
> > maintain the
> > system TLB is a good choice and it'll simplify the system software
> > design.
> > The proposal hopes to add a broadcast mode to the sfence.vma in the
> > riscv-privilege specification. To support the sfence.vma broadcast
> > mode,
> > there are two modification introduced below:
> > 
> >  1) Add PGD.PPN (root page table's PPN) as the unique identifier of
> > the
> >     address space in addition to asid/vmid. Compared to the
> > dynamically
> >     changed asid/vmid, PGD.PPN is fixed throughout the address
> > space life
> >     cycle. This feature enables uniform address space
> > identification
> >     between different TLB systems (actually, it's difficult to
> > unify the
> >     asid/vmid between the CPU system and the IOMMU system, because
> > their
> >     mechanisms are different)
> > 
> >  2) Modify the definition of the sfence.vma instruction from
> > synchronous
> >     mode to asynchronous mode, which means that the completion of
> > the TLB
> >     operation is not guaranteed when the sfence.vma instruction
> > retires.
> >     It needs to be completed by checking the flag bit on the hart.
> > The
> >     sfence.vma request finish can notify the software by generating
> > an
> >     interrupt. This function alleviates the large delay of TLB
> > invalidation
> >     in the PCI ATS system.
> > 
> > Add S1/S2.PGD.PPN for ASID/VMID
> > ===============================
> > 
> > PGD is global directory (defined in linux) and PPN is page physical
> > number
> > (defined in riscv-spec). PGD.PNN corresponds to the root page table
> > pointer
> > of the address space, i.e. mm->pgd (linux concept).
> > 
> > In CPU/IOMMU TLB, we use asid/vmid to distinguish the address space
> > of
> > process or virtual machine. Due to the limitation of id encoding,
> > it can
> > only represent a part(window) of the address space. S1/S2.PGD.PPN
> > are the
> > root page table's PPNs of the address spaces and S1/S2.PGD.PPN are
> > the
> > unique identifier of the address spaces.
> > 
> > For the CPU SMP system, you can use context switch to perform the
> > necessary
> > software mechanism to ensure that the asid/vmid on all harts is
> > consistent
> > (please refer to the arm64 asid mechanism). In this way, the TLB
> > broadcast
> > invalidation instruction can determine the address space processed
> > on all
> > harts by asid/vmid.
> > 
> > Different from the CPU SMP system, there is no context switch for
> > the
> > DMA-IOMMU system, so the unification with the CPU asid/vmid cannot
> > be
> > guaranteed. So we need a unique identifier for the address space to
> > establish a communication bridge between the TLBs of different
> > systems.
> > 
> > That is PGD.PPN (for virtualization scenarios: S1/S2.PGD.PPN)
> > 
> > current:
> >  sfence.vma  rs1 = vaddr, rs2 = asid
> >  hfence.vvma rs1 = vaddr, rs2 = asid
> >  hfence.gvma rs1 = gaddr, rs2 = vmid
> > 
> > proposed:
> >  sfence.vma  rs1 = vaddr, rs2 = mode:ppn:asid
> >  hfence.vvma rs1 = vaddr, rs2 = mode:ppn:asid
> >  hfence.gvma rs1 = gaddr, rs2 = mode:ppn:vmid
> > 
> >  mode      - broadcast | local
> >  ppn       - the PPN of the address space of the root page table
> >  vmid/asid - the window identifier of the address space
> > 
> > At the Linux Plumber Conference 2019 RISCV-MC, ref:[1], we've
> > showed two
> > IOMMU examples to explain how it work with hardware.
> > 
> > 1) In a lightweight IOMMU system (up to 64 address spaces), the
> > hardware
> >    could directly convert PGD.PPN into DID (IOMMU ASID)
> > 
> > 2) For the PCI ATS scenario, its IO ASID/VMID encoding space can
> > support
> >    a very large number of address spaces. We use two reverse
> > mapping
> >    tables to let the hardware translate S1/S2.PGD.PPN into IO
> > ASID/VMID.
> > 
> > ASYNC BROADCAST SFENCE.VMA
> > ===========================
> > 
> > To support the high latency broadcast sfence.vma operation in the
> > PCI ATS
> > usage scenario, we modify the sfence.vma from synchronous mode to
> > asynchronous mode. (For simpler implementation, if hardware only
> > implement
> > synchronous mode and software still work in asynchronous mode)
> > 
> > To implement the asynchronous mode, 3 features are added:
> >  1) sstatus:TLBI
> >     A "status bit - TLBI" is added to the sstatus register. The
> > TLBI status
> >     bit indicates if there are still outstanding sfence.vma
> > requests on the
> >     current hart.
> >     Value:
> >       1: sfence.vma requests are not completed.
> >       0: all sfece.vma requests completed, request queue is empty.
> > 
> >  2) sstatus:TLBIC
> >     A "control bits - TLBIC" is added to sstatus register. The
> > TLBIC control
> >     bits are controlled by software.
> >     "Write 1" will trigger the current hart check to see if there
> > are still
> >     outstanding sfence.vma requests. If there are unfinished
> > requests, an
> >     interrupt will be generated when the request is completed,
> > notifying the
> >     software that all of the current sfence.vma requests have been
> > completed.
> >     "Write 0" will cause nothing.
> > 
> >  3) supervisor interrupt register (sip & sie):TLBI finish interrupt
> >     A per-hart interrupt is added to supervisor interrupt
> > registers.
> >     When all sfence.vma requests are completed and sstatus:TLBIC
> > has been
> >     triggered, hart will receive a TLBI finish interrupt. Just like
> > timer,
> >     software and external interrupt's definition in sip & sie.
> > 
> > Fake code:
> > 
> > flush_tlb_page(vma, addr) {
> >     asid = cpu_asid(vma->vm_mm);
> >     ppn = PFN_DOWN(vma->vm_mm->pgd);
> > 
> >     sfence.vma (addr, 1|PPN_OFFSET(ppn)|asid); //1. start request
> > 
> >     while(sstatus:TLBI) if (time_out() > 1ms) break; //2. loop
> > check
> > 
> >     while (sstatus:TLBI) {
> >         ...
> >         set sstatus:TLBIC;
> >         wait_TLBI_finish_interrupt(); //3. wait irq, io_schedule
> >     }
> > }
> > 
> > Here we give 2 level check:
> >  1) loop check sstatus:TLBI, CPU could response Interrupt.
> >  2) set sstatus:TLBIC and wait for irq, CPU schedule out for other
> > task.
> > 
> > ACE-DVM Example
> > ===============
> > 
> > Honestly, "broadcasting addr, asid, vmid, S1/S2.PGD.PPN to
> > interconnects"
> > and "ASYNC SFENCE.VMA" could be implemented by ACE-DVM protocol ref
> > [2].
> > 
> > There are 3 types of transactions in DVM:
> > 
> >  - DVM operation
> >    Send all information to the interconnect, including addr, asid,
> >    S1.PGD.PPN, vmid, S2.PGD.PPN.
> > 
> >  - DVM synchronization
> >    Check that all DVM operations have been completed. If not, it
> > will use
> >    state machine to wait DVM complete requests.
> > 
> >  - DVM complete
> >    Return transaction from components, eg: IOMMU. If hart has
> > received all
> >    DVM completes which are triggered by sfence.vma instructions and
> >    "sstatus:TLBIC" has been set, a TLBI finish interrupt is
> > triggered.
> > 
> > (Actually, we do not need to implement the above functions strictly
> >  according to the ACE specification :P )
> > 
> >  1: https://www.linuxplumbersconf.org/event/4/contributions/307/
> >  2: AMBA AXI and ACE Protocol Specification - Distributed Virtual
> > Memory
> >     Transactions"
> > 
> > Signed-off-by: Guo Ren <ren_guo@c-sky.com>
> > Reviewed-by: Li Feiteng <feiteng_li@c-sky.com>
> > ---
> >  src/hypervisor.tex |  43 ++++++++-------
> >  src/supervisor.tex | 155
> > +++++++++++++++++++++++++++++++++++++++++------------
> >  2 files changed, 143 insertions(+), 55 deletions(-)
> > 
> > diff --git a/src/hypervisor.tex b/src/hypervisor.tex
> > index 47b90b2..3718819 100644
> > --- a/src/hypervisor.tex
> > +++ b/src/hypervisor.tex
> > @@ -1094,15 +1094,15 @@ The hypervisor extension adds two new
> > privileged fence instructions.
> >  \multicolumn{1}{c|}{opcode} \\
> >  \hline
> >  7 & 5 & 5 & 3 & 5 & 7 \\
> > -HFENCE.GVMA & vmid & gaddr & PRIV & 0 & SYSTEM \\
> > -HFENCE.VVMA & asid & vaddr & PRIV & 0 & SYSTEM \\
> > +HFENCE.GVMA & mode:ppn:vmid & gaddr & PRIV & 0 & SYSTEM \\
> > +HFENCE.VVMA & mode:ppn:asid & vaddr & PRIV & 0 & SYSTEM \\
> >  \end{tabular}
> >  \end{center}
> > 
> >  The hypervisor memory-management fence instructions, HFENCE.GVMA
> > and
> >  HFENCE.VVMA, are valid only in HS-mode when {\tt mstatus}.TVM=0,
> > or in M-mode
> >  (irrespective of {\tt mstatus}.TVM).
> > -These instructions perform a function similar to SFENCE.VMA
> > +These instructions perform a function similar to SFENCE.VMA
> > (broadcast/local)
> >  (Section~\ref{sec:sfence.vma}), except applying to the guest-
> > physical
> >  memory-management data structures controlled by CSR {\tt hgatp}
> > (HFENCE.GVMA)
> >  or the VS-level memory-management data structures controlled by
> > CSR {\tt vsatp}
> > @@ -1136,11 +1136,10 @@ An HFENCE.VVMA instruction applies only to
> > a single virtual machine, identified
> >  by the setting of {\tt hgatp}.VMID when HFENCE.VVMA executes.
> >  \end{commentary}
> > 
> > -When {\em rs2}$\neq${\tt x0}, bits XLEN-1:ASIDMAX of the value
> > held in {\em
> > -rs2} are reserved for future use and should be zeroed by software
> > and ignored
> > -by current implementations.
> > -Furthermore, if ASIDLEN~$<$~ASIDMAX, the implementation shall
> > ignore bits
> > -ASIDMAX-1:ASIDLEN of the value held in {\em rs2}.
> > +When {\em rs2}$\neq${\tt x0}, bits contain 3 informations: mode,
> > ppn, asid.
> > +1) mode control HFENCE.VVMA broadcast or not.
> > +2) ppn is the root page talbe's PPN of the asid address space.
> > +3) asid is the identifier of process in virtual machine.
> > 
> >  \begin{commentary}
> >  Simpler implementations of HFENCE.VVMA can ignore the guest
> > virtual address in
> > @@ -1168,11 +1167,10 @@ physical addresses in PMP address registers
> > (Section~\ref{sec:pmp}) and in page
> >  table entries (Sections \ref{sec:sv32}, \ref{sec:sv39},
> > and~\ref{sec:sv48}).
> >  \end{commentary}
> > 
> > -When {\em rs2}$\neq${\tt x0}, bits XLEN-1:VMIDMAX of the value
> > held in {\em
> > -rs2} are reserved for future use and should be zeroed by software
> > and ignored
> > -by current implementations.
> > -Furthermore, if VMIDLEN~$<$~VMIDMAX, the implementation shall
> > ignore bits
> > -VMIDMAX-1:VMIDLEN of the value held in {\em rs2}.
> > +When {\em rs2}$\neq${\tt x0}, bits contain 3 informations: mode,
> > vmid, ppn.
> > +1) mode control HFENCE.GVMA broadcast or not.
> > +2) ppn is the root page talbe's PPN of the vmid address space.
> > +3) vmid is the identifier of virtual machine.
> > 
> >  \begin{commentary}
> >  Simpler implementations of HFENCE.GVMA can ignore the guest
> > physical address in
> > @@ -1567,21 +1565,22 @@ register.
> >  \subsection{Memory-Management Fences}
> > 
> >  The behavior of the SFENCE.VMA instruction is affected by the
> > current
> > -virtualization mode V.  When V=0, the virtual-address argument is
> > an HS-level
> > -virtual address, and the ASID argument is an HS-level ASID.
> > +virtualization mode V.  When V=0, the rs1 argument is an HS-level
> > +virtual address, and the rs2 argument is an HS-level ASID and root
> > page table's PPN.
> >  The instruction orders stores only to HS-level address-translation 
> > structures
> >  with subsequent HS-level address translations.
> > 
> > -When V=1, the virtual-address argument to SFENCE.VMA is a guest
> > virtual
> > -address within the current virtual machine, and the ASID argument
> > is a VS-level
> > -ASID within the current virtual machine.
> > +When V=1, the rs1 argument to SFENCE.VMA is a guest virtual
> > +address within the current virtual machine, and the rs2 argument
> > is a VS-level
> > +ASID and root page table's PPN within the current virtual machine.
> >  The current virtual machine is identified by the VMID field of CSR
> > {\tt hgatp},
> > -and the effective ASID can be considered to be the combination of
> > this VMID
> > -with the VS-level ASID.
> > +and the effective ASID and root page table's PPN can be considered
> > to be the
> > +combination of this VMID and root page table's PPN with the VS-
> > level ASID and
> > +root page table's PPN.
> >  The SFENCE.VMA instruction orders stores only to the VS-level
> >  address-translation structures with subsequent VS-level address
> > translations
> > -for the same virtual machine, i.e., only when {\tt hgatp}.VMID is
> > the same as
> > -when the SFENCE.VMA executed.
> > +for the same virtual machine, i.e., only when {\tt hgatp}.VMID and
> > {\\tt hgatp}.PPN is
> > +the same as when the SFENCE.VMA executed.
> > 
> >  Hypervisor instructions HFENCE.GVMA and HFENCE.VVMA provide
> > additional
> >  memory-management fences to complement SFENCE.VMA.
> > diff --git a/src/supervisor.tex b/src/supervisor.tex
> > index ba3ced5..2877b7a 100644
> > --- a/src/supervisor.tex
> > +++ b/src/supervisor.tex
> > @@ -47,10 +47,12 @@ register keeps track of the processor's current
> > operating state.
> >  \begin{center}
> >  \setlength{\tabcolsep}{4pt}
> >  \scalebox{0.95}{
> > -\begin{tabular}{cWcccccWccccWcc}
> > +\begin{tabular}{cccWcccccWccccWcc}
> >  \\
> >  \instbit{31} &
> > -\instbitrange{30}{20} &
> > +\instbit{30} &
> > +\instbit{29} &
> > +\instbitrange{28}{20} &
> >  \instbit{19} &
> >  \instbit{18} &
> >  \instbit{17} &
> > @@ -66,6 +68,8 @@ register keeps track of the processor's current
> > operating state.
> >  \instbit{0} \\
> >  \hline
> >  \multicolumn{1}{|c|}{SD} &
> > +\multicolumn{1}{|c|}{TLBI} &
> > +\multicolumn{1}{|c|}{TLBIC} &
> >  \multicolumn{1}{c|}{\wpri} &
> >  \multicolumn{1}{c|}{MXR} &
> >  \multicolumn{1}{c|}{SUM} &
> > @@ -82,7 +86,7 @@ register keeps track of the processor's current
> > operating state.
> >  \multicolumn{1}{c|}{\wpri}
> >  \\
> >  \hline
> > -1 & 11 & 1 & 1 & 1 & 2 & 2 & 4 & 1 & 1 & 1 & 1 & 3 & 1 & 1 \\
> > +1 & 1 & 1 & 10 & 1 & 1 & 1 & 2 & 2 & 4 & 1 & 1 & 1 & 1 & 3 & 1 & 1
> > \\
> >  \end{tabular}}
> >  \end{center}
> >  }
> > @@ -95,10 +99,12 @@ register keeps track of the processor's current
> > operating state.
> >  {\footnotesize
> >  \begin{center}
> >  \setlength{\tabcolsep}{4pt}
> > -\begin{tabular}{cMFScccc}
> > +\begin{tabular}{cccMFScccc}
> >  \\
> >  \instbit{SXLEN-1} &
> > -\instbitrange{SXLEN-2}{34} &
> > +\instbit{SXLEN-2} &
> > +\instbit{SXLEN-3} &
> > +\instbitrange{SXLEN-4}{34} &
> >  \instbitrange{33}{32} &
> >  \instbitrange{31}{20} &
> >  \instbit{19} &
> > @@ -107,6 +113,8 @@ register keeps track of the processor's current
> > operating state.
> >   \\
> >  \hline
> >  \multicolumn{1}{|c|}{SD} &
> > +\multicolumn{1}{|c|}{TLBI} &
> > +\multicolumn{1}{|c|}{TLBIC} &
> >  \multicolumn{1}{c|}{\wpri} &
> >  \multicolumn{1}{c|}{UXL[1:0]} &
> >  \multicolumn{1}{c|}{\wpri} &
> > @@ -115,7 +123,7 @@ register keeps track of the processor's current
> > operating state.
> >  \multicolumn{1}{c|}{\wpri} &
> >   \\
> >  \hline
> > -1 & SXLEN-35 & 2 & 12 & 1 & 1 & 1 & \\
> > +1 & 1 & 1 & SXLEN-37 & 2 & 12 & 1 & 1 & 1 & \\
> >  \end{tabular}
> >  \begin{tabular}{cWWFccccWcc}
> >  \\
> > @@ -152,6 +160,17 @@ register keeps track of the processor's
> > current operating state.
> >  \label{sstatusreg}
> >  \end{figure*}
> > 
> > +The TLBI (read-only) bit indicates that any async sfence.vma
> > operations are
> > +still pended on the hart. The value:0 means that there is no
> > sfence.vma
> > +operations pending and value:1 means that there are still
> > sfence.vma operations
> > +pending on the hart.
> > +
> > +When the sstatus:TLBIC bit is written 1, it triggers the hardware
> > to check if
> > +there are any TLB invalidate operations being pended. When all
> > operations are
> > +finished, a TLB Invalidate finish interrupt will be triggered
> > +(see Section~\ref{sipreg}). When the sstatus:TLBIC bit is written
> > 0, it will
> > +cause nothing. Reading sstatus:TLBIC bit will alaways return 0.
> > +
> >  The SPP bit indicates the privilege level at which a hart was
> > executing before
> >  entering supervisor mode.  When a trap is taken, SPP is set to 0
> > if the trap
> >  originated from user mode, or 1 otherwise.  When an SRET
> > instruction
> > @@ -329,8 +348,10 @@ SXLEN-bit read/write register containing
> > interrupt enable bits.
> >  {\footnotesize
> >  \begin{center}
> >  \setlength{\tabcolsep}{4pt}
> > -\begin{tabular}{KcFcFcc}
> > -\instbitrange{SXLEN-1}{10} &
> > +\begin{tabular}{KcFcFcFcc}
> > +\instbitrange{SXLEN-1}{14} &
> > +\instbit{13} &
> > +\instbitrange{12}{10} &
> >  \instbit{9} &
> >  \instbitrange{8}{6} &
> >  \instbit{5} &
> > @@ -339,6 +360,8 @@ SXLEN-bit read/write register containing
> > interrupt enable bits.
> >  \instbit{0} \\
> >  \hline
> >  \multicolumn{1}{|c|}{\wpri} &
> > +\multicolumn{1}{c|}{STLBIP} &
> > +\multicolumn{1}{|c|}{\wpri} &
> >  \multicolumn{1}{c|}{SEIP} &
> >  \multicolumn{1}{c|}{\wpri} &
> >  \multicolumn{1}{c|}{STIP} &
> > @@ -346,7 +369,7 @@ SXLEN-bit read/write register containing
> > interrupt enable bits.
> >  \multicolumn{1}{c|}{SSIP} &
> >  \multicolumn{1}{c|}{\wpri} \\
> >  \hline
> > -SXLEN-10 & 1 & 3 & 1 & 3 & 1 & 1 \\
> > +SXLEN-14 & 1 & 3 & 1 & 3 & 1 & 3 & 1 & 1 \\
> >  \end{tabular}
> >  \end{center}
> >  }
> > @@ -359,8 +382,10 @@ SXLEN-10 & 1 & 3 & 1 & 3 & 1 & 1 \\
> >  {\footnotesize
> >  \begin{center}
> >  \setlength{\tabcolsep}{4pt}
> > -\begin{tabular}{KcFcFcc}
> > -\instbitrange{SXLEN-1}{10} &
> > +\begin{tabular}{KcFcFcFcc}
> > +\instbitrange{SXLEN-1}{14} &
> > +\instbit{13} &
> > +\instbitrange{12}{10} &
> >  \instbit{9} &
> >  \instbitrange{8}{6} &
> >  \instbit{5} &
> > @@ -369,6 +394,8 @@ SXLEN-10 & 1 & 3 & 1 & 3 & 1 & 1 \\
> >  \instbit{0} \\
> >  \hline
> >  \multicolumn{1}{|c|}{\wpri} &
> > +\multicolumn{1}{c|}{STLBIE} &
> > +\multicolumn{1}{|c|}{\wpri} &
> >  \multicolumn{1}{c|}{SEIE} &
> >  \multicolumn{1}{c|}{\wpri} &
> >  \multicolumn{1}{c|}{STIE} &
> > @@ -376,7 +403,7 @@ SXLEN-10 & 1 & 3 & 1 & 3 & 1 & 1 \\
> >  \multicolumn{1}{c|}{SSIE} &
> >  \multicolumn{1}{c|}{\wpri} \\
> >  \hline
> > -SXLEN-10 & 1 & 3 & 1 & 3 & 1 & 1 \\
> > +SXLEN-14 & 1 & 3 & 1 & 3 & 1 & 3 & 1 & 1 \\
> >  \end{tabular}
> >  \end{center}
> >  }
> > @@ -410,6 +437,12 @@ when the SEIE bit in the {\tt sie} register is
> > clear.  The implementation
> >  should provide facilities to mask, unmask, and query the cause of
> > external
> >  interrupts.
> > 
> > +A supervisor-level TLB Invalidate finish interrupt is pending if
> > the STLBIP bit
> > +in the {\tt sip} register is set.  Supervisor-level TLB Invalidate
> > finish
> > +interrupts are disabled when the STLBIE bit in the {\tt sie}
> > register is clear.
> > +When hart tlb invalidate operations are finished, hardware will
> > change sstatus:TLBI
> > +bit from 1 to 0 and trigger TLB Invalidate finish interrupt.
> > +
> >  \begin{commentary}
> >  The {\tt sip} and {\tt sie} registers are subsets of the {\tt mip}
> > and {\tt
> >  mie} registers.  Reading any field, or writing any writable field,
> > of {\tt
> > @@ -598,7 +631,9 @@ so is only guaranteed to hold supported
> > exception codes.
> >    1         & 5               & Supervisor timer interrupt \\
> >    1         & 6--8            & {\em Reserved} \\
> >    1         & 9               & Supervisor external interrupt \\
> > -  1         & 10--15          & {\em Reserved} \\
> > +  1         & 10--11          & {\em Reserved} \\
> > +  1         & 12              & Supervisor TLBI finish interrupt
> > \\
> > +  1         & 13--15          & {\em Reserved} \\
> >    1         & $\ge$16         & {\em Available for platform use}
> > \\ \hline
> >    0         & 0               & Instruction address misaligned \\
> >    0         & 1               & Instruction access fault \\
> > @@ -884,7 +919,7 @@ provided.
> >  \multicolumn{1}{c|}{opcode} \\
> >  \hline
> >  7 & 5 & 5 & 3 & 5 & 7 \\
> > -SFENCE.VMA & asid & vaddr & PRIV & 0 & SYSTEM \\
> > +SFENCE.VMA & mode:ppn:asid & vaddr & LOCAL & 0 & SYSTEM \\
> >  \end{tabular}
> >  \end{center}
> > 
> > @@ -899,21 +934,70 @@ from that hart to the memory-management data
> > structures.
> >  Further details on the behavior of this instruction are
> >  described in Section~\ref{virt-control} and Section~\ref{pmp-
> > vmem}.
> > 
> > +SFENCE.VMA is defined as an asynchronous completion instruction,
> > which means
> > +that the TLB operation is not guaranteed to complete when the
> > instruction retires.
> > +Software need check sstatus:TLBI to determine all TLB operations
> > complete.
> > +The sstatus:TLBI described in Section~\ref{sstatus}. When hardware
> > change
> > +sstatus:TLBI bit from 1 to 0, the TLB Invalidate finish interrupt
> > will be
> > +triggered.
> > +
> >  \begin{commentary}
> > -The SFENCE.VMA is used to flush any local hardware caches related
> > to
> > +The SFENCE.VMA is used to flush any local/remote hardware caches
> > related to
> >  address translation.  It is specified as a fence rather than a TLB
> >  flush to provide cleaner semantics with respect to which
> > instructions
> >  are affected by the flush operation and to support a wider variety
> > of
> >  dynamic caching structures and memory-management schemes. 
> > SFENCE.VMA
> >  is also used by higher privilege levels to synchronize page table
> > -writes and the address translation hardware.
> > +writes and the address translation hardware. There is a mode bit
> > to determine
> > +sfence.vma would broadcast on interconnect or not.
> >  \end{commentary}
> > 
> > -SFENCE.VMA orders only the local hart's implicit references to the
> > -memory-management data structures.
> > +\begin{figure}[h!]
> > +{\footnotesize
> > +\begin{center}
> > +\begin{tabular}{c@{}E@{}K}
> > +\instbit{31} &
> > +\instbitrange{30}{9} &
> > +\instbitrange{8}{0} \\
> > +\hline
> > +\multicolumn{1}{|c|}{{\tt MODE}} &
> > +\multicolumn{1}{|c|}{{\tt PPN (root page table)}} &
> > +\multicolumn{1}{|c|}{{\tt ASID}} \\
> > +\hline
> > +1 & 22 & 9 \\
> > +\end{tabular}
> > +\end{center}
> > +}
> > +\vspace{-0.1in}
> > +\caption{RV32 sfence.vma rs2 format.}
> > +\label{rv32satp}
> > +\end{figure}
> > +
> > +\begin{figure}[h!]
> > +{\footnotesize
> > +\begin{center}
> > +\begin{tabular}{@{}S@{}T@{}U}
> > +\instbitrange{63}{60} &
> > +\instbitrange{59}{16} &
> > +\instbitrange{15}{0} \\
> > +\hline
> > +\multicolumn{1}{|c|}{{\tt MODE}} &
> > +\multicolumn{1}{|c|}{{\tt PPN (root page table)}} &
> > +\multicolumn{1}{|c|}{{\tt ASID}} \\
> > +\hline
> > +4 & 44 & 16 \\
> > +\end{tabular}
> > +\end{center}
> > +}
> > +\vspace{-0.1in}
> > +\caption{RV64 sfence.vma rs2 format, for MODE values, only highest
> > bit:63 is
> > +valid and others are reserved.}
> > +\label{rv64satp}
> > +\end{figure}
> > 
> >  \begin{commentary}
> > -Consequently, other harts must be notified separately when the
> > +The mode's highest bit could control sfence.vma behavior with
> > 1:broadcast or 0:local.
> > +If only have mode:local, other harts must be notified separately
> > when the
> >  memory-management data structures have been modified.
> >  One approach is to use 1)
> >  a local data fence to ensure local writes are visible globally,
> > then
> > @@ -928,8 +1012,17 @@ modified for a single address mapping (i.e.,
> > one page or superpage), {\em rs1}
> >  can specify a virtual address within that mapping to effect a
> > translation
> >  fence for that mapping only.  Furthermore, for the common case
> > that the
> >  translation data structures have only been modified for a single
> > address-space
> > -identifier, {\em rs2} can specify the address space.  The behavior
> > of
> > -SFENCE.VMA depends on {\em rs1} and {\em rs2} as follows:
> > +identifier, {\em rs2} can specify the address space with {\tt
> > satp} format
> > +which include asid and root page table's PPN information.
> > +
> > +\begin{commentary}
> > +We use ASID and root page table's PPN to determine address space
> > and the format
> > +stored in rs2 is similar with {\tt satp} described in
> > Section~\ref{sec:satp}.
> > +ASID are used by local harts and root page table's PPN of the asid
> > are used by
> > +other different TLB systems, eg: IOMMU.
> > +\end{commentary}
> > +
> > +The behavior of SFENCE.VMA depends on {\em rs1} and {\em rs2} as
> > follows:
> > 
> >  \begin{itemize}
> >  \item If {\em rs1}={\tt x0} and {\em rs2}={\tt x0}, the fence
> > orders all
> > @@ -939,23 +1032,18 @@ SFENCE.VMA depends on {\em rs1} and {\em
> > rs2} as follows:
> >        all reads and writes made to any level of the page tables,
> > but only
> >        for the address space identified by integer register {\em
> > rs2}.
> >        Accesses to {\em global} mappings (see
> > Section~\ref{sec:translation})
> > -      are not ordered.
> > +      are not ordered. The mode field in rs2 is determine
> > broadcast or local.
> >  \item If {\em rs1}$\neq${\tt x0} and {\em rs2}={\tt x0}, the fence
> > orders
> >        only reads and writes made to the leaf page table entry
> > corresponding
> >        to the virtual address in {\em rs1}, for all address spaces.
> >  \item If {\em rs1}$\neq${\tt x0} and {\em rs2}$\neq${\tt x0}, the
> > fence
> >        orders only reads and writes made to the leaf page table
> > entry
> >        corresponding to the virtual address in {\em rs1}, for the
> > address
> > -      space identified by integer register {\em rs2}.
> > +      space identified by integer register {\em rs2}. The mode
> > field in rs2
> > +      is determine broadcast or local.
> >        Accesses to global mappings are not ordered.
> >  \end{itemize}
> > 
> > -When {\em rs2}$\neq${\tt x0}, bits SXLEN-1:ASIDMAX of the value
> > held in {\em
> > -rs2} are reserved for future use and should be zeroed by software
> > and ignored
> > -by current implementations.  Furthermore, if ASIDLEN~$<$~ASIDMAX,
> > the
> > -implementation shall ignore bits ASIDMAX-1:ASIDLEN of the value
> > held in {\em
> > -rs2}.
> > -
> >  \begin{commentary}
> >  Simpler implementations can ignore the virtual address in {\em
> > rs1} and
> >  the ASID value in {\em rs2} and always perform a global fence.
> > @@ -994,7 +1082,7 @@ can execute the same SFENCE.VMA instruction
> > while a different ASID is loaded
> >  into {\tt satp}, provided the next time {\tt satp} is loaded with
> > the recycled
> >  ASID, it is simultaneously loaded with the new page table.
> > 
> > -\item If the implementation does not provide ASIDs, or software
> > chooses to
> > +\item If the implementation does not provide ASIDs and PPNs, or
> > software chooses to
> >  always use ASID 0, then after every {\tt satp} write, software
> > should execute
> >  SFENCE.VMA with {\em rs1}={\tt x0}.  In the common case that no
> > global
> >  translations have been modified, {\em rs2} should be set to a
> > register other than
> > @@ -1003,13 +1091,14 @@ not flushed.
> > 
> >  \item If software modifies a non-leaf PTE, it should execute
> > SFENCE.VMA with
> >  {\em rs1}={\tt x0}.  If any PTE along the traversal path had its G
> > bit set,
> > -{\em rs2} must be {\tt x0}; otherwise, {\em rs2} should be set to
> > the ASID for
> > -which the translation is being modified.
> > +{\em rs2} must be {\tt x0}; otherwise, {\em rs2} should be set to
> > the ASID and
> > +root page table's PPN for which the translation is being modified.
> > 
> >  \item If software modifies a leaf PTE, it should execute
> > SFENCE.VMA with {\em
> >  rs1} set to a virtual address within the page.  If any PTE along
> > the traversal
> >  path had its G bit set, {\em rs2} must be {\tt x0}; otherwise,
> > {\em rs2}
> > -should be set to the ASID for which the translation is being
> > modified.
> > +should be set to the ASID and root page table's PPN for which the
> > translation
> > +is being modified.
> > 
> >  \item For the special cases of increasing the permissions on a
> > leaf PTE and
> >  changing an invalid PTE to a valid leaf, software may choose to
> > execute

