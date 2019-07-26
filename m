Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C7A9C76190
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 12:00:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25947218DA
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 12:00:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="PuesO2NF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726877AbfGZMAJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 08:00:09 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:34506 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726803AbfGZMAI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 08:00:08 -0400
Received: by mail-pg1-f196.google.com with SMTP id n9so18468377pgc.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2019 05:00:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=oI0R97fuUqdE0I/gmsxQ15AS3vPjppH94eLX72HdVQw=;
        b=PuesO2NFf6GdG9qQn54lobuItpHnil0Wxxng8M67UvgTIIUysJoYXduIe4MvOkNTWl
         OD4IWjiPDRDl+PdwxuwHyZJicwWd+0Qz0y+plyrJH1lLkOiDpjByvUNQ5Mi2y2Ewt+wt
         IqO0vcW6eTRmFG5agc4tOof+Mk5d025MsBWGOgTBC1O0pOvkFQ8WtjRdC5EWLIT+aisZ
         Oyp5gvdFlR+5oy1OaY29wW3PM1F6X3NCA0mlegY0IW2zvbvCH/k5MKs0ccqp0i3Q+C+u
         ac3AX9K4mQz6WngyWKlIezz3G7LfWxMOBqHbCb8+1RlfYkym4jij9kuyTpci1T2l4u9V
         TKOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=oI0R97fuUqdE0I/gmsxQ15AS3vPjppH94eLX72HdVQw=;
        b=BDXvztdeKkfvS5wawx31kofqPrQ8trotnPbliRUOwg/97JRhQUQbxXDSQqh0H84q8O
         Lq7nA3AEl8tfCfwfB5MqyW4VDJ2f+jVDlFynT7JuXD3xM2nWJOh1toU3CDCoPLSl/LIB
         Oxm5orc7ZSuAzqJqtoD8ec3k+Ui4Z9Ra38kzakY5iCMcbiTMIpCTClfSCvoPG/XX1dG2
         DIQQJZ7+god+SKsMsT4jsFhXPmnXyIO/35cr3pCv0jRr5+HqBID4m2qj/KWaG+FQm8vo
         2q7KCImps50JOsgEro9IDdL/C6jh7ENtBTDPB+aYJpvikflC0rrqr50/svuJl4Ks98kf
         nByg==
X-Gm-Message-State: APjAAAVval2AYIfxxWutPTwOaTyjdDt6BW4/CWM/2nx8Y/vj+5KTLwua
        Dpp7pT55bfCXu1dW7tf/WpCNL8Bt9gM=
X-Google-Smtp-Source: APXvYqx819gN2+zWvFVhXTwxqLv7So4wMoGBA003enGDBW04aZp+5++DAbdRI7GEgDudVXrIf/T1zQ==
X-Received: by 2002:a17:90a:71ca:: with SMTP id m10mr44092840pjs.27.1564142406990;
        Fri, 26 Jul 2019 05:00:06 -0700 (PDT)
Received: from brauner.io ([172.58.30.217])
        by smtp.gmail.com with ESMTPSA id q1sm62253913pfg.84.2019.07.26.05.00.02
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 26 Jul 2019 05:00:06 -0700 (PDT)
Date:   Fri, 26 Jul 2019 13:59:59 +0200
From:   Christian Brauner <christian@brauner.io>
To:     Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        David Howells <dhowells@redhat.com>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>
Subject: Regression in 5.3 for some FS_USERNS_MOUNT (aka
 user-namespace-mountable) filesystems
Message-ID: <20190726115956.ifj5j4apn3tmwk64@brauner.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey everyone,

We have another mount api regression. With current 5.3-rc1 it is not
possible anymore to mount filesystems that have FS_USERNS_MOUNT set and
their fs_context's global member set to true. At least sysfs is
affected, likely also cgroup{2}fs.

The commit that introduced the regression is:

commit 0ce0cf12fc4c6a089717ff613d76457052cf4303
Author: Al Viro <viro@zeniv.linux.org.uk>
Date:   Sun May 12 15:42:48 2019 -0400

    consolidate the capability checks in sget_{fc,userns}()

    ... into a common helper - mount_capable(type, userns)

    Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

mount_capable() will select the user namespace in which to check for
CAP_SYS_ADMIN based on the global property of the filesystem's
fs_context.

Since sysfs has global set to true mount_capable() will check for
CAP_SYS_ADMIN in init_user_ns and fail the mount with EPERM for any
non-init userns root. The same check is present in sget_fc().

To me it looks like that global is overriding FS_USERNS_MOUNT which
seems odd. Afaict, there are two ways to fix this:
- remove global from sysfs
- remove the global check from mount_capable() and possibly sget_fc()

The latter feels more correct but I'm not sure *why* that global thing
got introduced. Seems there could be an additional flag on affected
filesystems instead of this "global" thing. But not sure.

I can whip up a patch in case that does make sense.
And it would probably be a good thing if we had some sort of test (if
there isn't one already) so that this doesn't happen again. It could be
as simple as:

unshare -U -m --map-root -n
mkdir whatever
mount -t sysfs sysfs ./whatever

Thanks!
Christian
