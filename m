Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56E32C31E40
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 08:46:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D6DA204EC
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 08:46:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727234AbfHLIqY convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 04:46:24 -0400
Received: from esa3.mentor.iphmx.com ([68.232.137.180]:54411 "EHLO
        esa3.mentor.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727092AbfHLIqY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 04:46:24 -0400
X-Greylist: delayed 426 seconds by postgrey-1.27 at vger.kernel.org; Mon, 12 Aug 2019 04:46:23 EDT
IronPort-SDR: pkjN+1IXqOJaBSbWgp/0jBuN6Ozm2YK7+V3Ji83Sm0arX+ufoBG9Bxmho4RgnWmgcl+JVuTrMz
 1ZOl5z+dc3gqHPx2QI8k+dVb1eVLH0hmh+Jfj4TZBKJ+cA4YTEqfPxY9JQ63o+UdLer4FFlhoM
 KInP+8DPrgRsvabPCgrTHthmSra+30gHSscuMpmHrO6wntCciHs5/MjY3lk+oZoAOMcnW9X63N
 WrwHdtF/Oz0YhfxeP9R+EL5s+b4R4Oa6eHmVPJNOJ8uTD4eARFpk8qfQfjSLDa4WsGs2SJuHSU
 pH0=
X-IronPort-AV: E=Sophos;i="5.64,376,1559548800"; 
   d="scan'208";a="40369519"
Received: from orw-gwy-02-in.mentorg.com ([192.94.38.167])
  by esa3.mentor.iphmx.com with ESMTP; 12 Aug 2019 00:39:16 -0800
IronPort-SDR: +Yg37kcuRs+rQjEk120ZznBf9VC3+tkavwMZjAGnak0evfJ4Tw/ezheA5TwQGQdrTGKiJ1wLaR
 KTyw2Gb0WOR9CmIXqF/CCgqLdwATFd9St2WUK8dMsLC1EaNoFNWotWnL9coqw/jgxrpqA8q5fF
 l/tkLuzLT4mVn0IkRumLl8ti+Yxz6JMhwPAjEo6YRR1CKJX1gs41WKczIMd0CdNGwt6VVF7p5h
 OIzFybOrLY1orLSVC4jHWfMjH596Sce5f6yVQZoDSZDdnAM2mPV1DFoa1JtaMavy7vvhy9KwEp
 pVg=
From:   "Schmid, Carsten" <Carsten_Schmid@mentor.com>
To:     Wei Yang <richard.weiyang@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
CC:     "bp@suse.de" <bp@suse.de>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "osalvador@suse.de" <osalvador@suse.de>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "richardw.yang@linux.intel.com" <richardw.yang@linux.intel.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Subject: AW: Resend [PATCH] kernel/resource.c: invalidate parent when freed
 resource has childs
Thread-Topic: Resend [PATCH] kernel/resource.c: invalidate parent when freed
 resource has childs
Thread-Index: AQHVTrktoAw70LsxJE6oaOICoAXoo6bzWCGAgAACFoCAACE+AIADtCnw
Date:   Mon, 12 Aug 2019 08:39:10 +0000
Message-ID: <4072490bab6f4b34986380d77b4744a7@SVR-IES-MBX-03.mgc.mentorg.com>
References: <1565278859475.1962@mentor.com> <1565358624103.3694@mentor.com>
 <20190809223831.fk4uyrzscr366syr@master>
 <CAHk-=wi_9sdMxurjZ1MbNnxt-pA=dqoyf8Fdn9aYc8xvjjnTBg@mail.gmail.com>
 <20190810004458.mio4vp3nk6jl2hyh@master>
In-Reply-To: <20190810004458.mio4vp3nk6jl2hyh@master>
Accept-Language: de-DE, en-IE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [137.202.0.90]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Ursprüngliche Nachricht-----
> Von: Wei Yang [mailto:richard.weiyang@gmail.com]
> Gesendet: Samstag, 10. August 2019 02:45
> An: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: Wei Yang <richard.weiyang@gmail.com>; Schmid, Carsten
> <Carsten_Schmid@mentor.com>; bp@suse.de; dan.j.williams@intel.com;
> mingo@kernel.org; dave.hansen@linux.intel.com; linux-
> kernel@vger.kernel.org; bhelgaas@google.com; osalvador@suse.de;
> rdunlap@infradead.org; richardw.yang@linux.intel.com;
> gregkh@linuxfoundation.org
> Betreff: Re: Resend [PATCH] kernel/resource.c: invalidate parent when
> freed resource has childs
> 
> On Fri, Aug 09, 2019 at 03:45:59PM -0700, Linus Torvalds wrote:
> >On Fri, Aug 9, 2019 at 3:38 PM Wei Yang <richard.weiyang@gmail.com>
> wrote:
> >>
> >> In theory, child may have siblings. Would it be possible to have several
> >> devices under xhci-hcd?
> >
> >I'm less interested in the xhci-hcd case - which I certainly *hope* is
> >fixed already? - than in "if this happens somewhere else".
> >
> 
> Agree, this is what I want to say.
> 
Unfortunately this xhci-hcd case is not fixed yet.
I'm working on a driver fix proposal, discussing with Hans de Goede who
wrote the intel_xhci_usb_sw platform driver.

For me there is nothing invalid in the intel_xhci_usb_sw driver.
It is initialized from xhci-hcd/xhci-pci in 
  xhci_pci_probe --> xhci_ext_cap_init --> xhci_create_intel_xhci_sw_pdev
which then does
  devm_add_action_or_reset(dev, xhci_intel_unregister_pdev, pdev)

So far, so good. Doesn't look bad.

When unbinding the xhci-hcd driver, i can see that xhci_pci_remove executes,
and after this the xhci_intel_unregister_pdev is called.
This is what fails because xhci_pci_remove removes the parent of the resource created
in the xhci_create_intel_xhci_sw_pdev.
So the "devm framework" which is used here fails in this specific case.
Very unintentional.
The proposal will call xhci_intel_unregister_pdev from within the xhci-pci in a similar way
like the driver is created. So we will have the child killed before the parent :)

> >So if we do want to remove the parent (which may be a good idea with a
> >warning), and want to make sure that the children are really removed
> >from the resource hierarchy, we should do somethiing like
> >
> >  static bool detach_children(struct resource *res)
> >  {
> >        res = res->child;
> >        if (!res)
> >                return false;
> >        do {
> >                res->parent = NULL;
> >                res = res->sibling;
> >        } while (res);
> >        return true;
> >  }
> >
> >and then we could write the __release_region() warning as
> >
> >        /* You should not release a resource that has children */
> >        WARN_ON_ONCE(detach_children(res));
> >
Fine for me, this extended sanity check. This didn't came up to my mind.
Because i have a reproducer, i can test it and send it as V2.
If you have any additional ideas, let me know.

> 
> I am thinking about why this could happen.
See above explanation.

> 
> To guard the core kernel code, it looks reasonable.
> 
Exactly my motivation :)

> >or something?
> >
> >NOTE! The above is entirely untested, and written purely in my mail
> >reader. It might be seriously buggy, including not compiling, or doing
> >odd things. See it more as a "maybe something like this" code snippet
> >example than any kind of final form.
> >
> >               Linus
> 
I'll implement and check it, of course. Development as usual.
Thanks!

Carsten
> --
> Wei Yang
> Help you, Help me
