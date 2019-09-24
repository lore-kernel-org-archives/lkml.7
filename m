Return-Path: <SRS0=YpA9=XT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AB97C432C1
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 02:39:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B5A12064A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 02:39:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="C6mIDqbf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392295AbfIXCj3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 22:39:29 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:46934 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727899AbfIXCj3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 22:39:29 -0400
Received: by mail-lj1-f194.google.com with SMTP id e17so213401ljf.13
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2019 19:39:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=69FsbDk3UWzV2ado0kISftXd4Dxcwqhctiepyrz5wa4=;
        b=C6mIDqbf80FLU0LnPzHEgkLF483jKLHXlK521PxkYT8ynqbV8+qmaX6hC6QUZLK6Ci
         R6R+o+sG1tbtfrFryoHmi1EJos8bldXIMSa0fnKH7XvXPkaidzC8TDamUykQp6mp2fR+
         P5vkgc4xkx8IisaqRFW0opFHrBXIkoqspri95omg2fzp7dlBMRk7unyLy/eoinDeFGai
         089zZb9QVFMHJDN7P8t1LLLtUnwG+Eofl9yVuoMVWorWBYzyxsmn3GNti20ZnjAuQmf3
         4ZaRgIWUEaVdRWDjFZ5DHwztxESROQWBJHXO16bzJZlfRSpcgLk0SO+HPIsB13HYjQlj
         rn5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=69FsbDk3UWzV2ado0kISftXd4Dxcwqhctiepyrz5wa4=;
        b=fAn455e3jo7Ql6i4qsWXm1xgK8V+0jJ6zWfBFezirIuPY9Ld3E6Ry8L1DqOnL7V9K8
         s28m1sWrECQZqZZjkRt6Hg8IrhfCcdLgmSph5yJEaqWKpO5kNUphlD0QFtol17qf9ADy
         3itcY9NIgw2McTqlTehuq2fWGa2PGN7Ne1qslyUsY6d4v9eMSXxqpE0IpMdSn+vuLjm8
         d2MDJyJ3T/nl/IEk3O/yWs4pwPp89U9NKpUfzmYrYxZE6FkGpAbHe1j10AgOj8zo64Q8
         yaon+ck/GXzGWGUlMS5V0N4G+QkuBqBaVq6qBmGkC3Wwcys8oNZ6gNSj1rLko/wrblm1
         YgSw==
X-Gm-Message-State: APjAAAWgff5C20TNeHGEq2o++VrylTicGpbsy+EIltBysfzMsB/vPIJm
        P39pSQLcdj40ST3Koz7bFdpxi0hmCPVcnOYIEagV
X-Google-Smtp-Source: APXvYqw9Hua23+qq2hsh3uzAjoZt49lXUPzD6s52CvB4ggcm8e3fEjygRKpDpy8RUBGqKckGHwPovNGUeUR0Y9CRNz4=
X-Received: by 2002:a2e:9615:: with SMTP id v21mr282460ljh.46.1569292765707;
 Mon, 23 Sep 2019 19:39:25 -0700 (PDT)
MIME-Version: 1.0
References: <20190923155041.GA14807@codemonkey.org.uk> <CAHC9VhTyz7fd+iQaymVXUGFe3ZA5Z_WkJeY_snDYiZ9GP6gCOA@mail.gmail.com>
 <20190923165806.GA21466@codemonkey.org.uk> <CAHC9VhTh+cD5pkb8JAHnG1wa9-UgivSb7+-yjjYaD+6vhyYKjA@mail.gmail.com>
 <20190923194901.GA2787@codemonkey.org.uk> <d5d92540ca5aab8916ac4d93f6b5677ab52d2e7d.camel@redhat.com>
In-Reply-To: <d5d92540ca5aab8916ac4d93f6b5677ab52d2e7d.camel@redhat.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 23 Sep 2019 22:39:14 -0400
Message-ID: <CAHC9VhSpZ0_oGgdFzM=ZCdh-Z1MfBb4Eruado-Dx52WFcO16ug@mail.gmail.com>
Subject: Re: ntp audit spew.
To:     Eric Paris <eparis@redhat.com>
Cc:     Dave Jones <davej@codemonkey.org.uk>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        linux-audit@redhat.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 23, 2019 at 3:49 PM Eric Paris <eparis@redhat.com> wrote:
> Is this the thing where systemd is listening on the multicast netlink
> socket and causes everything to come out kmesg as well?

I don't think so, but I'm still a little confused as to why DaveJ is
seeing these records, so I'll go with a weak "maybe" ;)

> On Mon, 2019-09-23 at 15:49 -0400, Dave Jones wrote:
> > On Mon, Sep 23, 2019 at 02:57:08PM -0400, Paul Moore wrote:
> >  > On Mon, Sep 23, 2019 at 12:58 PM Dave Jones <
> > davej@codemonkey.org.uk> wrote:
> >  > > On Mon, Sep 23, 2019 at 12:14:14PM -0400, Paul Moore wrote:
> >  > >  > On Mon, Sep 23, 2019 at 11:50 AM Dave Jones <
> > davej@codemonkey.org.uk> wrote:
> >  > >  > >
> >  > >  > > I have some hosts that are constantly spewing audit
> > messages like so:
> >  > >  > >
> >  > >  > > [46897.591182] audit: type=1333 audit(1569250288.663:220):
> > op=offset old=2543677901372 new=2980866217213
> >  > >  > > [46897.591184] audit: type=1333 audit(1569250288.663:221):
> > op=freq old=-2443166611284 new=-2436281764244
> >  > >  > > [48850.604005] audit: type=1333 audit(1569252241.675:222):
> > op=offset old=1850302393317 new=3190241577926
> >  > >  > > [48850.604008] audit: type=1333 audit(1569252241.675:223):
> > op=freq old=-2436281764244 new=-2413071187316
> >  > >  > > [49926.567270] audit: type=1333 audit(1569253317.638:224):
> > op=offset old=2453141035832 new=2372389610455
> >  > >  > > [49926.567273] audit: type=1333 audit(1569253317.638:225):
> > op=freq old=-2413071187316 new=-2403561671476
> >  > >  > >
> >  > >  > > This gets emitted every time ntp makes an adjustment, which
> > is apparently very frequent on some hosts.
> >  > >  > >
> >  > >  > >
> >  > >  > > Audit isn't even enabled on these machines.
> >  > >  > >
> >  > >  > > # auditctl -l
> >  > >  > > No rules
> >  > >  >
> >  > >  > What happens when you run 'auditctl -a never,task'?  That
> > *should*
> >  > >  > silence those messages as the audit_ntp_log() function has
> > the
> >  > >  > requisite audit_dummy_context() check.
> >  > >
> >  > > They still get emitted.
> >  > >
> >  > >  > FWIW, this is the distro
> >  > >  > default for many (most? all?) distros; for example, check
> >  > >  > /etc/audit/audit.rules on a stock Fedora system.
> >  > >
> >  > > As these machines aren't using audit, they aren't running auditd
> > either.
> >  > > Essentially: nothing enables audit, but the kernel side
> > continues to log
> >  > > ntp regardless (no other audit messages seem to do this).
> >  >
> >  > What does your kernel command line look like?  Do you have
> > "audit=1"
> >  > somewhere in there?
> >
> > nope.
> >
> > ro root=LABEL=/ biosdevname=0 net.ifnames=0 fsck.repair=yes
> > systemd.gpt_auto=0 pcie_pme=nomsi ipv6.autoconf=0 erst_disable
> > crashkernel=128M console=tty0 console=ttyS1,57600
> > intel_iommu=tboot_noforce
> >
> >       Dave
> >
>


-- 
paul moore
www.paul-moore.com
