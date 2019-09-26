Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49E3BC432C2
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 10:13:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18649217F4
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 10:13:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726655AbfIZKNz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Sep 2019 06:13:55 -0400
Received: from emh04.mail.saunalahti.fi ([62.142.5.110]:49200 "EHLO
        emh04.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726029AbfIZKNy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 06:13:54 -0400
Received: from ydin.reaktio.net (reaktio.net [85.76.255.15])
        by emh04.mail.saunalahti.fi (Postfix) with ESMTP id 9E0B330074;
        Thu, 26 Sep 2019 13:13:50 +0300 (EEST)
Received: by ydin.reaktio.net (Postfix, from userid 1001)
        id DD00636C0F6; Thu, 26 Sep 2019 13:13:48 +0300 (EEST)
Date:   Thu, 26 Sep 2019 13:13:47 +0300
From:   Pasi =?iso-8859-1?Q?K=E4rkk=E4inen?= <pasik@iki.fi>
To:     "Spassov, Stanislav" <stanspas@amazon.de>
Cc:     Chao Gao <chao.gao@intel.com>, "jgross@suse.com" <jgross@suse.com>,
        "sstabellini@kernel.org" <sstabellini@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "baijiaju1990@gmail.com" <baijiaju1990@gmail.com>,
        "jbeulich@suse.com" <jbeulich@suse.com>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        "boris.ostrovsky@oracle.com" <boris.ostrovsky@oracle.com>,
        "Woodhouse, David" <dwmw@amazon.co.uk>,
        "roger.pau@citrix.com" <roger.pau@citrix.com>
Subject: Re: [Xen-devel] [PATCH] xen: xen-pciback: Reset MSI-X state when
 exposing a device
Message-ID: <20190926101347.GD28704@reaktio.net>
References: <1543976357-1053-1-git-send-email-chao.gao@intel.com>
 <2c0ad3bf96551ea6e96e812229507221b76876c6.camel@amazon.de>
 <20190913152818.GA688@gao-cwp>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190913152818.GA688@gao-cwp>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Stanislav,

On Fri, Sep 13, 2019 at 11:28:20PM +0800, Chao Gao wrote:
> On Fri, Sep 13, 2019 at 10:02:24AM +0000, Spassov, Stanislav wrote:
> >On Thu, Dec 13, 2018 at 07:54, Chao Gao wrote:
> >>On Thu, Dec 13, 2018 at 12:54:52AM -0700, Jan Beulich wrote:
> >>>>>> On 13.12.18 at 04:46, <chao.gao@intel.com> wrote:
> >>>> On Wed, Dec 12, 2018 at 08:21:39AM -0700, Jan Beulich wrote:
> >>>>>>>> On 12.12.18 at 16:18, <chao.gao@intel.com> wrote:
> >>>>>> On Wed, Dec 12, 2018 at 01:51:01AM -0700, Jan Beulich wrote:
> >>>>>>>>>> On 12.12.18 at 08:06, <chao.gao@intel.com> wrote:
> >>>>>>>> On Wed, Dec 05, 2018 at 09:01:33AM -0500, Boris Ostrovsky wrote:
> >>>>>>>>>On 12/5/18 4:32 AM, Roger Pau Monné wrote:
> >>>>>>>>>> On Wed, Dec 05, 2018 at 10:19:17AM +0800, Chao Gao wrote:
> >>>>>>>>>>> I find some pass-thru devices don't work any more across guest reboot.
> >>>>>>>>>>> Assigning it to another guest also meets the same issue. And the only
> >>>>>>>>>>> way to make it work again is un-binding and binding it to pciback.
> >>>>>>>>>>> Someone reported this issue one year ago [1]. More detail also can be
> >>>>>>>>>>> found in [2].
> >>>>>>>>>>>
> >>>>>>>>>>> The root-cause is Xen's internal MSI-X state isn't reset properly
> >>>>>>>>>>> during reboot or re-assignment. In the above case, Xen set maskall bit
> >>>>>>>>>>> to mask all MSI interrupts after it detected a potential security
> >>>>>>>>>>> issue. Even after device reset, Xen didn't reset its internal maskall
> >>>>>>>>>>> bit. As a result, maskall bit would be set again in next write to
> >>>>>>>>>>> MSI-X message control register.
> >>>>>>>>>>>
> >>>>>>>>>>> Given that PHYSDEVOPS_prepare_msix() also triggers Xen resetting MSI-X
> >>>>>>>>>>> internal state of a device, we employ it to fix this issue rather than
> >>>>>>>>>>> introducing another dedicated sub-hypercall.
> >>>>>>>>>>>
> >>>>>>>>>>> Note that PHYSDEVOPS_release_msix() will fail if the mapping between
> >>>>>>>>>>> the device's msix and pirq has been created. This limitation prevents
> >>>>>>>>>>> us calling this function when detaching a device from a guest during
> >>>>>>>>>>> guest shutdown. Thus it is called right before calling
> >>>>>>>>>>> PHYSDEVOPS_prepare_msix().
> >>>>>>>>>> s/PHYSDEVOPS/PHYSDEVOP/ (no final S). And then I would also drop the
> >>>>>>>>>> () at the end of the hypercall name since it's not a function.
> >>>>>>>>>>
> >>>>>>>>>> I'm also wondering why the release can't be done when the device is
> >>>>>>>>>> detached from the guest (or the guest has been shut down). This makes
> >>>>>>>>>> me worry about the raciness of the attach/detach procedure: if there's
> >>>>>>>>>> a state where pciback assumes the device has been detached from the
> >>>>>>>>>> guest, but there are still pirqs bound, an attempt to attach to
> >>>>>>>>>> another guest in such state will fail.
> >>>>>>>>>
> >>>>>>>>>I wonder whether this additional reset functionality could be done out
> >>>>>>>>>of xen_pcibk_xenbus_remove(). We first do a (best effort) device reset
> >>>>>>>>>and then do the extra things that are not properly done there.
> >>>>>>>> 
> >>>>>>>> No. It cannot be done in xen_pcibk_xenbus_remove() without modifying
> >>>>>>>> the handler of PHYSDEVOP_release_msix. To do a successful Xen internal
> >>>>>>>> MSI-X state reset, PHYSDEVOP_{release, prepare}_msix should be finished
> >>>>>>>> without error. But ATM, xen expects that no msi is bound to pirq when
> >>>>>>>> doing PHYSDEVOP_release_msix. Otherwise it fails with error code -EBUSY.
> >>>>>>>> However, the expectation isn't guaranteed in xen_pcibk_xenbus_remove().
> >>>>>>>> In some cases, if qemu fails to unmap MSIs, MSIs are unmapped by Xen
> >>>>>>>> at last minute, which happens after device reset in 
> >>>>>>>> xen_pcibk_xenbus_remove().
> >>>>>>>
> >>>>>>>But that may need taking care of: I don't think it is a good idea to have
> >>>>>>>anything left from the prior owning domain when the device gets reset.
> >>>>>>>I.e. left over IRQ bindings should perhaps be forcibly cleared before
> >>>>>>>invoking the reset;
> >>>>>> 
> >>>>>> Agree. How about pciback to track the established IRQ bindings? Then
> >>>>>> pciback can clear irq binding before invoking the reset.
> >>>>>
> >>>>>How would pciback even know of those mappings, when it's qemu
> >>>>>who establishes (and manages) them?
> >>>> 
> >>>> I meant to expose some interfaces from pciback. And pciback serves
> >>>> as the proxy of IRQ (un)binding APIs.
> >>>
> >>>If at all possible we should avoid having to change more parties (qemu,
> >>>libxc, kernel, hypervisor) than really necessary. Remember that such
> >>>a bug fix may want backporting, and making sure affected people have
> >>>all relevant components updated is increasingly difficult with their
> >>>number growing.
> >>>
> >>>>>>>in fact I'd expect this to happen in the course of
> >>>>>>>domain destruction, and I'd expect the device reset to come after the
> >>>>>>>domain was cleaned up. Perhaps simply an ordering issue in the tool
> >>>>>>>stack?
> >>>>>> 
> >>>>>> I don't think reversing the sequences of device reset and domain
> >>>>>> destruction would be simple. Furthermore, during device hot-unplug,
> >>>>>> device reset is done when the owner is alive. So if we use domain
> >>>>>> destruction to enforce all irq binding cleared, in theory, it won't be
> >>>>>> applicable to hot-unplug case (if qemu's hot-unplug logic is
> >>>>>> compromised).
> >>>>>
> >>>>>Even in the hot-unplug case the tool stack could issue unbind
> >>>>>requests, behind the back of the possibly compromised qemu,
> >>>>>once neither the guest nor qemu have access to the device
> >>>>>anymore.
> >>>> 
> >>>> But currently, tool stack doesn't know the remaining IRQ bindings.
> >>>> If tool stack can maintaine IRQ binding information of a pass-thru
> >>>> device (stored in Xenstore?), we can come up with a clean solution
> >>>> without modifying linux kernel and Xen.
> >>>
> >>>If there's no way for the tool stack to either find out the bindings
> >>>or "blindly" issue unbind requests (accepting them to fail), then a
> >>>"wildcard" unbind operation may want adding. Or, perhaps even
> >>>better, XEN_DOMCTL_deassign_device could unbind anything left
> >>>in place for the specified device.
> >>
> >>Good idea. I will take this advice.
> >>
> >>Thanks
> >>Chao
> >
> >I am having the same issue, and cannot find a fix in either xen-pciback or the Xen codebase.
> >Was a solution ever pushed as a result of this thread?
> >
> 
> I submitted patches [1] to Xen community. But I didn't get it merged.
> We made a change in device driver to disable MSI-X during guest OS
> shutdown to mitigate the issue. But when guest or qemu was crashed, we
> encountered this issue again. I have no plan to get back to these
> patches. But if you want to fix the issue completely along what the
> patches below did, please go ahead.
> 
> [1]: https://lists.xenproject.org/archives/html/xen-devel/2019-01/msg01227.html
> 
> Thanks
> Chao
> 

Stanislav: Are you able to continue the work with these patches, to get them merged? 


Thanks,

-- Pasi

