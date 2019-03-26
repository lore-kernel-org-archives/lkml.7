Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7C0EC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 15:01:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85F152075C
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 15:01:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731894AbfCZPBm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 11:01:42 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:48576 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726278AbfCZPBl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 11:01:41 -0400
Received: from p5492e2fc.dip0.t-ipconnect.de ([84.146.226.252] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1h8na0-0007Wb-TL; Tue, 26 Mar 2019 16:01:33 +0100
Date:   Tue, 26 Mar 2019 16:01:32 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Andi Kleen <ak@linux.intel.com>
cc:     "Chang S. Bae" <chang.seok.bae@intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Ravi Shankar <ravi.v.shankar@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Cooper <andrew.cooper3@citrix.com>, x86@kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Arjan van de Ven <arjan@linux.intel.com>
Subject: New feature/ABI review process [was Re: [RESEND PATCH v6 04/12]
 x86/fsgsbase/64:..]
In-Reply-To: <20190326003804.GK18020@tassilo.jf.intel.com>
Message-ID: <alpine.DEB.2.21.1903261010380.1789@nanos.tec.linutronix.de>
References: <1552680405-5265-1-git-send-email-chang.seok.bae@intel.com> <1552680405-5265-5-git-send-email-chang.seok.bae@intel.com> <alpine.DEB.2.21.1903251107300.1798@nanos.tec.linutronix.de> <20190326003804.GK18020@tassilo.jf.intel.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andi,

On Mon, 25 Mar 2019, Andi Kleen wrote:

> >    So on user space to kernel space transitions swapping in kernel GS should
> >    simply do:
> >      userGS = RDGSBASE()
> >      WRGSBASE(kernelGS)
> 
> This would also need to find kernelGS first, by doing RDPID and then
> reading it  from memory in the right index
> (which might be a full cache miss if you're unlucky)

I'm well aware of that.

> SWAPGS will be a lot faster, especially in these rare worst cases
> because it has all its state inside the CPU.

The well known 'will/might/could/should' word weaseling is not solving
anything.

If you want to advocate the more complex design of mixed SWAPGS/FSGSBASE
then provide numbers and not hand-waving. Numbers of real-world workloads,
not numbers of artificial test cases which exercise the rare worst case.

Yes, it's extra work and it's well spent. If the numbers are not
significantly different then the simpler and consistent design is a clear
win.

According to the changelog on which I reacted you seem to have investigated
that already. Let me cite it again:

  > Accessing user GSBASE needs a couple of SWAPGS operations. It is
  > avoidable if the user GSBASE is saved at kernel entry, being updated as
  > changes, and restored back at kernel exit. However, it seems to spend
  > more cycles for savings and restorations. Little or no benefit was
  > measured from experiments.

So little or no benefit was measured. I don't see how that maps to your
'SWAPGS will be a lot faster' claim. One of those claims is obviously
wrong.

Aside of this needs more than numbers:

  1) Proper documentation how the mixed bag is managed.

  2) Extensive comments explaining the subtle inner workings and caveats.

  3) Proper changelogs.

You have a track record of not caring much about either of these, but I
very much care for good reasons. I've been bitten by glued on and half
baked patches from Intel in the past 10 years so many times, that I'm
simply refusing to take anything which is not properly structured and
documented.

Especially not when it is touching sensitive areas like this and also has
an impact on the user space ABI.

> BTW you managed to only review after Chang went on a long vacation.

I'm terribly sorry about that. I'll try to adjust my own schedules and
workflow to Intel employees vacation plans in the future.

> <rant>
> I don't understand why it takes that long to review these changes
> It's one of the largest performance improvements for the context
> switch and the NMI in many years plus gives a new free register
> to user space, but it only makes progress at a glacial pace.
> The original patches for this were posted in 2016.
> </rant>

Care to look at the real history of this:

  11/2015: First patch-set posted by you, which was rejected on technical grounds

So this so important feature was in limbo for 20 months until Luto picked it
up again. That's surely the fault of the x86 maintainers, right?

  07/2017: Discussion about ABI considerations initiated by Andy Lutomirksi.

And it takes another 8 month until patches come around:

  03/19/2018: V1 from Chang. Reviewed within days

2 month gap caused by Intel:

  05/31/2018: V2 Request from Andy to split the set

  06/04/2018: Base-V1 The first chunk of changes.

  06/06/2018: Base-V2 Slight modifications

  06/07/2018: Base-V3 Slight modifications. Review on 08/18

  06/20/2018: Base-V4 Review on 06/22

  06/27/2018: Base-V5

2 month gap caused by busy maintainers. You know what they were busy with
at that time, right? Chasing subtle bugs in the so perfect L1TF patches
which were thrown over the fence by you and dealing with the Intel induced
speculation crap to have a consistent and maintainable mitigation including
proper documentation.

  08/23/2018: Base-V5 Resend. Review on 9/14

  09/18/2018: Base-V6. Merged 10/08

  10/23/2018: Full-V3. Review immediate

  10/24/2018: Regression detected caused by Base-V6

The so perfect base patch set caused a regression and it takes more than a
month to fix it properly:

  10/30/2018: Fix-V1. Broken
  10/31/2018: Fix-V2. Broken
  11/01/2018: Fix-V3. Broken
  11/14/2018: Fix-V4. Broken
  11/15/2018: Fix-V5. Broken
  11/26/2018: Fix-V6. Finally

2 months to address the Full-V3 feedback:

  01/16/2019: Full-V4. Change request

  02/01/2019: Full-V5. Review immediate

  02/13/2019: Full-V6.

1 month gap caused by busy maintainers. Ash on my main...

  03/15/2019: Full-V6 resend

So just to put this straight:

 Out of 40 month since the first post in 11/2015:

   20 months nothing happened from Intel side
    8 months consumed to produce the next set
    1 month  to fix a regression
    2 months consumed to react on review feedback
  ----------------------------------------------
   31 months

 versus:

   2 months maintainers dealing with Intel crap
   1 month  maintainers being busy

 The rest is the usual review/re-post ping pong delay which sums up, but
 from the larger gaps more than 75% are Intel induced and 7% maintainer
 induced.

 It's pretty obvious why it takes that long, right?

Back to the current version of patches:

Putting the design question aside. Even if the mixed SWAPGS/FSGSBASE thing
is the right thing to do, the patch set is not acceptable in the current
form. Again for the record:

 1) Lack of documentation.

 2) Lack of proper justification and explanation of the design.

 3) Patches doing different things at once.

 4) A yet to be explained inconsistency in the NMI code.

 5) Pointless and mindless local_irq_save/restore() in switch_to() which
    this performance important patch set tries to optimize.

I as a maintainer don't have to decode all of the above from a jumble of
complex patches, right?

Just for the record:

  You can rant until you're blue in the face, it's not going to change
  the fact that this stuff is not ready. It's neither changing the fact
  that all of the above could have been addressed by Intel _before_
  posting V6.

  You very well know the expectations and it's not my personal pet peeve,
  it's clearly documented in Documentation/process/*.

I'm dead tired of your unfounded complaints and of your permanent refusal to
collaborate. Keep that up and the last x86 maintainer who was willing to
deal with you in the past 10 years will finally open up a reserved slot
in his email filters to /dev/null.

Thanks,

	Thomas
