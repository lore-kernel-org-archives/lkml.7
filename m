Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDFF7C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 14:22:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A20E20879
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 14:22:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="IV7XqtMV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727755AbfCROWk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 10:22:40 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:36308 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726868AbfCROWk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 10:22:40 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x2IEIePk071559;
        Mon, 18 Mar 2019 14:22:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=wKj1KavL702tErJSLUNTLTzy+VoLjqEdgKAv4hPSexU=;
 b=IV7XqtMVDUX1LzG0jZAScj/Un28HglLXwtpQAC3TuKc09L6mUX8pPM1+HAC54z01V1Ni
 X8hwj0D9fo2BUIukmS6dxMMeiQAzppGzkXUdZIdHoFTOmsirdpyftK2O7xPWjRq/Fzsb
 WQJa8XPh7U2s5gAGrReW4alRsxPtKfUBI6uGYuKl6/k2IUZYSmi+sxNLI5r/H8ndhiw5
 Q5i0u+oDV/2JwtsCVemtBrFq3WCRr0sVdJJyUYTJMPgm0aT3D4GrKFeUQA2CLl2llcFh
 SAzqil/Su+KaSwVYtZfTZMz2Z1L92cEd+1nfNb7tQjiv6UoJ+ifY1OT1uaBpqvMJsZBe Gg== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by aserp2130.oracle.com with ESMTP id 2r8pnef239-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 18 Mar 2019 14:22:34 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x2IEMXaY005849
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 18 Mar 2019 14:22:33 GMT
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x2IEMX5Q028088;
        Mon, 18 Mar 2019 14:22:33 GMT
Received: from char.us.oracle.com (/10.152.32.25)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 18 Mar 2019 07:22:32 -0700
Received: by char.us.oracle.com (Postfix, from userid 1000)
        id 96E926A013C; Mon, 18 Mar 2019 10:22:32 -0400 (EDT)
Date:   Mon, 18 Mar 2019 10:22:32 -0400
From:   Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To:     "Raslan, KarimAllah" <karahmed@amazon.de>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "rkrcmar@redhat.com" <rkrcmar@redhat.com>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH v6 00/14] KVM/X86: Introduce a new guest mapping interface
Message-ID: <20190318142232.GC16697@char.us.oracle.com>
References: <1548966284-28642-1-git-send-email-karahmed@amazon.de>
 <1552914624.8242.1.camel@amazon.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1552914624.8242.1.camel@amazon.de>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9198 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1903180107
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 18, 2019 at 01:10:24PM +0000, Raslan, KarimAllah wrote:
> I guess this patch series missed the 5.1 merge window? :)

Were there any outstanding fixes that had to be addressed?

> 
> On Thu, 2019-01-31 at 21:24 +0100, KarimAllah Ahmed wrote:
> > Guest memory can either be directly managed by the kernel (i.e. have a "struct
> > page") or they can simply live outside kernel control (i.e. do not have a
> > "struct page"). KVM mostly support these two modes, except in a few places
> > where the code seems to assume that guest memory must have a "struct page".
> > 
> > This patchset introduces a new mapping interface to map guest memory into host
> > kernel memory which also supports PFN-based memory (i.e. memory without 'struct
> > page'). It also converts all offending code to this interface or simply
> > read/write directly from guest memory. Patch 2 is additionally fixing an
> > incorrect page release and marking the page as dirty (i.e. as a side-effect of
> > using the helper function to write).
> > 
> > As far as I can see all offending code is now fixed except the APIC-access page
> > which I will handle in a seperate series along with dropping
> > kvm_vcpu_gfn_to_page and kvm_vcpu_gpa_to_page from the internal KVM API.
> > 
> > The current implementation of the new API uses memremap to map memory that does
> > not have a "struct page". This proves to be very slow for high frequency
> > mappings. Since this does not affect the normal use-case where a "struct page"
> > is available, the performance of this API will be handled by a seperate patch
> > series.
> > 
> > So the simple way to use memory outside kernel control is:
> > 
> > 1- Pass 'mem=' in the kernel command-line to limit the amount of memory managed 
> >    by the kernel.
> > 2- Map this physical memory you want to give to the guest with:
> >    mmap("/dev/mem", physical_address_offset, ..)
> > 3- Use the user-space virtual address as the "userspace_addr" field in
> >    KVM_SET_USER_MEMORY_REGION ioctl.
> > 
> > v5 -> v6:
> > - Added one extra patch to ensure that support for this mem= case is complete
> >   for x86.
> > - Added a helper function to check if the mapping is mapped or not.
> > - Added more comments on the struct.
> > - Setting ->page to NULL on unmap and to a poison ptr if unused during map
> > - Checking for map ptr before using it.
> > - Change kvm_vcpu_unmap to also mark page dirty for LM. That requires
> >   passing the vCPU pointer again to this function.
> > 
> > v4 -> v5:
> > - Introduce a new parameter 'dirty' into kvm_vcpu_unmap
> > - A horrible rebase due to nested.c :)
> > - Dropped a couple of hyperv patches as the code was fixed already as a
> >   side-effect of another patch.
> > - Added a new trivial cleanup patch.
> > 
> > v3 -> v4:
> > - Rebase
> > - Add a new patch to also fix the newly introduced enlightned VMCS.
> > 
> > v2 -> v3:
> > - Rebase
> > - Add a new patch to also fix the newly introduced shadow VMCS.
> > 
> > Filippo Sironi (1):
> >   X86/KVM: Handle PFNs outside of kernel reach when touching GPTEs
> > 
> > KarimAllah Ahmed (13):
> >   X86/nVMX: handle_vmon: Read 4 bytes from guest memory
> >   X86/nVMX: Update the PML table without mapping and unmapping the page
> >   KVM: Introduce a new guest mapping API
> >   X86/nVMX: handle_vmptrld: Use kvm_vcpu_map when copying VMCS12 from
> >     guest memory
> >   KVM/nVMX: Use kvm_vcpu_map when mapping the L1 MSR bitmap
> >   KVM/nVMX: Use kvm_vcpu_map when mapping the virtual APIC page
> >   KVM/nVMX: Use kvm_vcpu_map when mapping the posted interrupt
> >     descriptor table
> >   KVM/X86: Use kvm_vcpu_map in emulator_cmpxchg_emulated
> >   KVM/nSVM: Use the new mapping API for mapping guest memory
> >   KVM/nVMX: Use kvm_vcpu_map for accessing the shadow VMCS
> >   KVM/nVMX: Use kvm_vcpu_map for accessing the enlightened VMCS
> >   KVM/nVMX: Use page_address_valid in a few more locations
> >   kvm, x86: Properly check whether a pfn is an MMIO or not
> > 
> >  arch/x86/include/asm/e820/api.h |   1 +
> >  arch/x86/kernel/e820.c          |  18 ++++-
> >  arch/x86/kvm/mmu.c              |   5 +-
> >  arch/x86/kvm/paging_tmpl.h      |  38 +++++++---
> >  arch/x86/kvm/svm.c              |  97 ++++++++++++------------
> >  arch/x86/kvm/vmx/nested.c       | 160 +++++++++++++++-------------------------
> >  arch/x86/kvm/vmx/vmx.c          |  19 ++---
> >  arch/x86/kvm/vmx/vmx.h          |   9 ++-
> >  arch/x86/kvm/x86.c              |  14 ++--
> >  include/linux/kvm_host.h        |  28 +++++++
> >  virt/kvm/kvm_main.c             |  64 ++++++++++++++++
> >  11 files changed, 267 insertions(+), 186 deletions(-)
> > 
> 
> 
> 
> Amazon Development Center Germany GmbH
> Krausenstr. 38
> 10117 Berlin
> Geschaeftsfuehrer: Christian Schlaeger, Ralf Herbrich
> Ust-ID: DE 289 237 879
> Eingetragen am Amtsgericht Charlottenburg HRB 149173 B
> 
