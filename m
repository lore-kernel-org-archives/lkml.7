Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E956C3A59F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 20:43:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB6F72184D
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 20:43:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="BhBSgTH8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730167AbfHZUnH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 16:43:07 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:39734 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727219AbfHZUnG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 16:43:06 -0400
Received: by mail-lf1-f67.google.com with SMTP id x3so13339880lfn.6
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2019 13:43:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=p1NZAj4MoRkEkLRbyMnIKojmRRt6i7vvfvZf586VwIo=;
        b=BhBSgTH8xbSi4yH5k6ZClji6uofBcvgRFuCrXQ+CfzrGpCHRlBrmOUJoIDPK1Gut9A
         WeahJGrJaNFNJwh0c/HgVZ5jPoTI/vpzov6ASOuJQEtACsUmt+Beyil6eR8J/Sss3A87
         OGpnVux86xYACb9VXRrwuzhiAyIqJfCWBBHWywTueMKLM8lD7uDSxeV8QSQ9hDqpCFUd
         bfkaSEWpK6hDVV0fDEMpS1NHcTuH8tbbhqk/7kWxtF7SXHZ1LpnYNJph7ydAOBf15ESd
         u7M9Rxl/8fsyV5YrpZ3WWzTS4/AYyQrC5ytQBACXDLrNCEDWRjQOZdMUFw9l8YZq0pXH
         N87A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=p1NZAj4MoRkEkLRbyMnIKojmRRt6i7vvfvZf586VwIo=;
        b=axneNMGSBRdDPCSg8BVm78U4bzbOFk/KUlYRBkXBwuEbXndRXtbfQmuQmuwconutT6
         so5UkNC0lolPgar/zh1A4xgPwoWWQOlA2wrnLzaLGmkQ84uX+cwXUAK8cXB/6pndpTrl
         CwkY0lA87EzjclfPzqlNnp1wnb28EJo+Nlgg4WAr9Wm7UkMYjlKLmus01at6iEQmDj7W
         p9Jfcdg9bKWNcrrjJZmMBg5SL8fET1zOfbr7uX76lkWkpqZduawPoIVCAtJEbW6MJcSN
         TBonIVR5hogbBeO/yIanTbyHiZlpsw4LIK/PziQNs8vOnjbMD4U5YL/Ax/9bn4rdUV7I
         podg==
X-Gm-Message-State: APjAAAW/a9JcL7TPSgxXxtWP2wsVyhK1LsLKqGJHhmEy0n0V3UsQxVSY
        9dJP+iVIykO37G0bgUjU1Eg6D5WakiqlSkg2tkEgX/gVDQ==
X-Google-Smtp-Source: APXvYqw98hCeYYBXk4YZHX6MIRcUUU+QfmECiO74pTKPAWw5m13mQig24osCxIldeAW+pbY5W0hdOp3iRnl5sSj14J4=
X-Received: by 2002:ac2:4474:: with SMTP id y20mr2537810lfl.31.1566852183926;
 Mon, 26 Aug 2019 13:43:03 -0700 (PDT)
MIME-Version: 1.0
References: <4997df37-4a80-5cf5-effc-0a6f040c4528@huawei.com>
 <CAHC9VhS_DCBRX6kkmiSYBzq+ELN2AYRypRN6vR_J1+JOi2FDvw@mail.gmail.com> <ce8efa9d-f2b6-5adc-0442-c73e632c6903@huawei.com>
In-Reply-To: <ce8efa9d-f2b6-5adc-0442-c73e632c6903@huawei.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 26 Aug 2019 16:42:52 -0400
Message-ID: <CAHC9VhS8Rq8J9MBUvqNeEO9pQRzx7mT=EfDagw=MQ2oO8jHbyw@mail.gmail.com>
Subject: Re: [Question] audit_names use after delete in audit_filter_inodes
To:     Chen Wandun <chenwandun@huawei.com>
Cc:     linux-kernel@vger.kernel.org, linux-audit@redhat.com,
        Eric Paris <eparis@redhat.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 22, 2019 at 3:22 AM Chen Wandun <chenwandun@huawei.com> wrote:
> On 2019/8/21 23:36, Paul Moore wrote:
> > On Wed, Aug 21, 2019 at 5:31 AM Chen Wandun <chenwandun@huawei.com> wrote:
> >>
> >> Hi,
> >> Recently, I hit a use after delete in audit_filter_inodes,
> >
> > ...
> >
> >> the call stack is below:
> >> [321315.077117] CPU: 6 PID: 8944 Comm: DefSch0100 Tainted: G           OE  ----V-------   3.10.0-327.62.59.83.w75.x86_64 #1
> >> [321315.077117] Hardware name: OpenStack Foundation OpenStack Nova, BIOS rel-1.8.1-0-g4adadbd-20170107_142945-9_64_246_229 04/01/2014
> >
> > It looks like this is a vendor kernel and not an upstream kernel, yes?
>
> I analysed the upstream kernel about audit, and found there is no significant change
> in audit_names add/read/delete since v3.10.

The number of changes in a Linux v3.10 based distro kernel and a
modern upstream are quite significant, regardless of what you might
see by comparing a limited number of functions/structs.  I once again
suggest you contact your distribution provider for support, or move to
a modern Linux kernel so that upstream can better understand your
problem.

-- 
paul moore
www.paul-moore.com
