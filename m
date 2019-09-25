Return-Path: <SRS0=wETr=XU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2199FC432C2
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 18:59:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD3D521D7B
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 18:59:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="WMZNBE5p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732572AbfIYS7M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 14:59:12 -0400
Received: from mail.efficios.com ([167.114.142.138]:57860 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731534AbfIYS7L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 14:59:11 -0400
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 0B257335D60
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2019 14:59:10 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id Oa5__yd2dmKe for <linux-kernel@vger.kernel.org>;
        Wed, 25 Sep 2019 14:59:09 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 30F6D335D2F
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2019 14:59:07 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 30F6D335D2F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1569437947;
        bh=M+5wTJ7Oc7RbuXq5XhyoHrnkhza4obbAj8DwzdN14d4=;
        h=MIME-Version:From:Date:Message-ID:To;
        b=WMZNBE5pcp2kPbLAwtU2AUFC1LDbdXzPY0uWtJe2jjCfeNXtGhRQwmYg+N2lKKob3
         NUMCfL04m/0h+OVDYgEwbiJweE5TuZxZaTCMHjBbJsW5FxYk1+T/58F2wsgPBORCpf
         FmBnYJDC+GR1TP2/DCcN3xCmXx7oSVq5WEZOr9+aGcpegWPTHMP1XiksxtSFmoEv8N
         frRCSwT+7z1wjIWR/92t0EKd7v8V2lPAHnjYAEMmmmh3QLrvNirblqei/eZvv3vlUE
         Z4FqnFgBscLnKD/gvZB6CdOIC2ISU0xCaaFYbFbHM89CGrsKjUerjLfz3xB1BgzlEu
         ynslRUHXLSt4A==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id p2ctOyPOpuRM for <linux-kernel@vger.kernel.org>;
        Wed, 25 Sep 2019 14:59:07 -0400 (EDT)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
        by mail.efficios.com (Postfix) with ESMTPSA id CF3F1335D13
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2019 14:59:06 -0400 (EDT)
Received: by mail-lf1-f48.google.com with SMTP id c195so5017160lfg.9
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2019 11:59:06 -0700 (PDT)
X-Gm-Message-State: APjAAAWqc/gomGalc5SlvnzFawxMTT4/vd994F5SiQn3rVkSv13PdiPJ
        mvc6akIxaGCuBaenpfuog0e3Je/I/vENDy6H4wY=
X-Google-Smtp-Source: APXvYqxupdV6DvN1bo+FJI2sEhdoOrm5PLbFXeD35LNT2VRv9RE9TlQFhVTopiUUHFOHUiQPrHYatBKUuEi8lPbbzaw=
X-Received: by 2002:ac2:44d2:: with SMTP id d18mr7209529lfm.67.1569437945323;
 Wed, 25 Sep 2019 11:59:05 -0700 (PDT)
MIME-Version: 1.0
From:   =?UTF-8?Q?J=C3=A9r=C3=A9mie_Galarneau?= 
        <jeremie.galarneau@efficios.com>
Date:   Wed, 25 Sep 2019 14:58:28 -0400
X-Gmail-Original-Message-ID: <CA+jJMxvkqjXHy3DnV5MVhFTL2RUhg0WQ-XVFW3ngDQOdkFq0PA@mail.gmail.com>
Message-ID: <CA+jJMxvkqjXHy3DnV5MVhFTL2RUhg0WQ-XVFW3ngDQOdkFq0PA@mail.gmail.com>
Subject: Unmerged patches adding audit when protected_regular/fifos sysctl
 causes EACCES
To:     keescook@chromium.org
Cc:     s.mesoraca16@gmail.com, viro@zeniv.linux.org.uk,
        dan.carpenter@oracle.com, akpm@linux-foundation.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        lkml <linux-kernel@vger.kernel.org>,
        torvalds@linux-foundation.org, solar@openwall.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kees,

I have noticed that the two top-most patches of your protected-creat
branch were never merged upstream [1]. Those patches add audit logs
whenever the protected_regular or protected_fifo sysctl prevent the
creation of a file/fifo.

They were mentioned in the v4 thread [2] of the "main" patch and
seemed acceptable, but they were no longer mentioned in v5 [3], which
was merged.

Now that systemd enables those sysctls by default (v241+), I got
bitten pretty hard by this check and it took me a while to figure out
what was happening [4]. I ended up catching it by adding a bunch of
printk(), including where you proposed to add an audit log statement.

I just found your two patches while implementing what you proposed almost 1=
:1.

Was there a reason why those were abandoned? Otherwise, would you mind
resubmitting them?

Thanks!
J=C3=A9r=C3=A9mie

[1] https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git/log/?h=
=3Dkspp/userspace/protected-creat
[2] https://lkml.org/lkml/2018/4/10/840
[3] https://lore.kernel.org/lkml/20180416175918.GA13494@beast/
[4] https://github.com/lttng/lttng-tools/commit/cf86ff2c4ababd01fea7ab2c9c2=
89cb7c0a1bcd5

--=20
J=C3=A9r=C3=A9mie Galarneau
EfficiOS Inc.
http://www.efficios.com
