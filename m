Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8FA5C04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 17:53:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2BCA2075B
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 17:53:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="ZRgmtNHk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727740AbfE1Rxu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 13:53:50 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:40603 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727371AbfE1Rxt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 13:53:49 -0400
Received: by mail-it1-f193.google.com with SMTP id h11so5343745itf.5
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2019 10:53:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:user-agent:in-reply-to:references:mime-version
         :content-transfer-encoding:subject:to:cc:from:message-id;
        bh=sqqyFvVLuV+EyzNyJ3sSbUh/EAFp8lvomo9t+R/7pFU=;
        b=ZRgmtNHkmaFRiCGj7OwYatGf+2cH3ECMFsrypBx+5shvHbiy5d9FaPDkXUacp3B+wR
         J3OiXHWGMVxwjRWa4mffZ4W6IJxhqwRlIUTMDsO3DSU4iY6kP79q5VPcYsDLyYlCQcW2
         QFhFbh4RHSf81QDnsNl0UbAg357LKP7IuVgPUMO2B3bT2CZ+LfJ+oAE4U5eKSFTCOxnB
         VaN4Y0FI2sQ/ES2DqB8r9KX1fJJz8R3tUz60o3vo8T8W1CbK7ffRqVjg8TGyA7WZhzHz
         3Z95CDlN1JCXjdGo1T7DUpdwu4urIdkNmx8GCdVrBcBzCxVI3KpnOssfU5PWSU88S4+F
         qe6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:user-agent:in-reply-to:references
         :mime-version:content-transfer-encoding:subject:to:cc:from
         :message-id;
        bh=sqqyFvVLuV+EyzNyJ3sSbUh/EAFp8lvomo9t+R/7pFU=;
        b=Yf9UqgFGrNct3lizU4MKowxYUisKRPQVk0y5omJEN6bxIF+QVoggeKKUIx5dCamzbB
         XfngCqGYa4ll9BuYH+9zrXczv7u7BgL9fHt+cBxwO0sUKyG38bGtVYn1N52q+WErjq6C
         IGCNJNkTqmg8oOXWcDBbeTdv8YVg5FJc87ghuzcPG+c1VCtimfVmSi8zDGlNMcxnxDte
         4Gyn8c631KC5f4UtPA11KBmdQ7VeNTGpYEwRgSZZIpcv/OKOGC3ggeTuq3gbs9I3gmnk
         KcfAREJkv/auMzKum/F9qg8DUAjC0C37QEg6ts02UqqYFV9mJtWs7CsQyWh/v/Er37ew
         7yqA==
X-Gm-Message-State: APjAAAX9aAa0AsdCN+BOaapKEhsYjFD/CfI5EKtWgF1WZFmFZlJYUDCl
        3DG20cJaF6Gis2RT/cfUb9AEhQ==
X-Google-Smtp-Source: APXvYqyW8K1UAo17CVlve5MIdTDLaiTNknZt43lMcs6eHU4AiffgkLJKCZtOaCXkBvwV/dNI8mSDbQ==
X-Received: by 2002:a05:660c:482:: with SMTP id a2mr3668478itk.91.1559066028828;
        Tue, 28 May 2019 10:53:48 -0700 (PDT)
Received: from [26.67.58.222] ([172.56.12.182])
        by smtp.gmail.com with ESMTPSA id i7sm4822662iop.79.2019.05.28.10.53.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 May 2019 10:53:48 -0700 (PDT)
Date:   Tue, 28 May 2019 19:53:41 +0200
User-Agent: K-9 Mail for Android
In-Reply-To: <20190528175020.13343-6-acme@kernel.org>
References: <20190528175020.13343-1-acme@kernel.org> <20190528175020.13343-6-acme@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 05/14] tools headers UAPI: Sync linux/sched.h with the kernel
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
CC:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Brendan Gregg <brendan.d.gregg@gmail.com>,
        =?ISO-8859-1?Q?Luis_Cl=E1udio_Gon=E7alves?= <lclaudio@redhat.com>
From:   Christian Brauner <christian@brauner.io>
Message-ID: <5DED7BD2-76E6-4647-8794-348EC25A4690@brauner.io>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On May 28, 2019 7:50:11 PM GMT+02:00, Arnaldo Carvalho de Melo <acme@kernel=
=2Eorg> wrote:
>From: Arnaldo Carvalho de Melo <acme@redhat=2Ecom>
>
>To pick up the change in:
>
>  b3e583825266 ("clone: add CLONE_PIDFD")
>
>This requires changes in the 'perf trace' beautification routines for
>the 'clone' syscall args, which is done in a followup patch=2E
>
>This silences the following perf build warning:
>
>Warning: Kernel ABI header at 'tools/include/uapi/linux/sched=2Eh'
>differs from latest version at 'include/uapi/linux/sched=2Eh'
>  diff -u tools/include/uapi/linux/sched=2Eh include/uapi/linux/sched=2Eh
>
>Cc: Adrian Hunter <adrian=2Ehunter@intel=2Ecom>
>Cc: Brendan Gregg <brendan=2Ed=2Egregg@gmail=2Ecom>
>Cc: Christian Brauner <christian@brauner=2Eio>
>Cc: Jiri Olsa <jolsa@kernel=2Eorg>
>Cc: Luis Cl=C3=A1udio Gon=C3=A7alves <lclaudio@redhat=2Ecom>
>Cc: Namhyung Kim <namhyung@kernel=2Eorg>
>Link:
>https://lkml=2Ekernel=2Eorg/n/tip-lenja6gmy26dkt0ybk747qgq@git=2Ekernel=
=2Eorg
>Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat=2Ecom>
>---
> tools/include/uapi/linux/sched=2Eh | 1 +
> 1 file changed, 1 insertion(+)
>
>diff --git a/tools/include/uapi/linux/sched=2Eh
>b/tools/include/uapi/linux/sched=2Eh
>index 22627f80063e=2E=2Eed4ee170bee2 100644
>--- a/tools/include/uapi/linux/sched=2Eh
>+++ b/tools/include/uapi/linux/sched=2Eh
>@@ -10,6 +10,7 @@
>#define CLONE_FS	0x00000200	/* set if fs info shared between processes
>*/
>#define CLONE_FILES	0x00000400	/* set if open files shared between
>processes */
>#define CLONE_SIGHAND	0x00000800	/* set if signal handlers and blocked
>signals shared */
>+#define CLONE_PIDFD	0x00001000	/* set if a pidfd should be placed in
>parent */
>#define CLONE_PTRACE	0x00002000	/* set if we want to let tracing
>continue on the child too */
>#define CLONE_VFORK	0x00004000	/* set if the parent wants the child to
>wake it up on mm_release */
>#define CLONE_PARENT	0x00008000	/* set if we want to have the same
>parent as the cloner */

Thanks for doing that!

Reviewed-by: Christian Brauner <christian@brauner=2Eio>
