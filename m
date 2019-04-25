Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62004C43219
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 17:11:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB08720717
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 17:11:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="k+HE2G33"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728803AbfDYRLg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 13:11:36 -0400
Received: from mail-vs1-f68.google.com ([209.85.217.68]:45919 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726026AbfDYRLf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 13:11:35 -0400
Received: by mail-vs1-f68.google.com with SMTP id o10so282944vsp.12
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2019 10:11:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lcyOU7ZwkJVqSoqQ41D9CfXRO6/IIRiCI85pPcRiMBM=;
        b=k+HE2G33XzagDRH2hhFSXLMAVAzaRFMw+JJBpvcr17WlVZR015M+qSvE7rz1wcjPXV
         Z/P4EgPfzOag13g8G6LuO3FQB3fzQKXY902T8gNn86/aeY7Cgu18QtNOQ4BRqrQuUZQt
         rke6FbYxTBfxCMxqVTUgLZu/demazCDfN4XI0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lcyOU7ZwkJVqSoqQ41D9CfXRO6/IIRiCI85pPcRiMBM=;
        b=b8ki6BLSSYZpijVaG84hcvmhfNoxdFaawbmQ/8F52/Ox23wHJSMN5t4RjpFodr0Zpl
         9289PpkySM5ZdFK0sUTS7WLbaG13D0QZnrNtFXRFMWBzZ/CwPvzNwZFmxzofGxnQ3hfd
         otKGvwSqd7utjMqbxS8X59bNyDfvW3SRjF9DGVQ2Dm+BVRKVFa42ygRqMVw/C5b64p8F
         nDexCvLhxYIZ7R5BpAeXVsO0dc2LXqzYTStXleFne3jtWt19jwpwrUzF+zqLBZykwqfS
         HPj1bJv9vYvnk7DC4uMUT9SfEKPI4G3N7jxFJy+xXLrE+YQYWLTwf89DD6Kc8tqFXBfi
         AxIA==
X-Gm-Message-State: APjAAAX0ZMiYyA8uepPRh+AA6p+JHfBDRYXk4K1kTz886VdZ5v8aIqOh
        ueN4FmwBcLtGesqy4DNud19mIkVj75w=
X-Google-Smtp-Source: APXvYqxyVIUXDkqImoe2hipuemx78UNU8J8kU4c3JDA7L+AZIyAjS2GWnTv5To7qQVMJ+KiKx133sw==
X-Received: by 2002:a67:b106:: with SMTP id w6mr21973867vsl.16.1556212293366;
        Thu, 25 Apr 2019 10:11:33 -0700 (PDT)
Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com. [209.85.221.176])
        by smtp.gmail.com with ESMTPSA id n202sm6583893vke.5.2019.04.25.10.11.32
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Apr 2019 10:11:32 -0700 (PDT)
Received: by mail-vk1-f176.google.com with SMTP id h71so137134vkf.5
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2019 10:11:32 -0700 (PDT)
X-Received: by 2002:a1f:3458:: with SMTP id b85mr21127933vka.4.1556212291639;
 Thu, 25 Apr 2019 10:11:31 -0700 (PDT)
MIME-Version: 1.0
References: <20190424231237.14776-1-keescook@chromium.org> <a3ca267e-8e1e-65da-77c8-c7010a39354b@kernel.org>
 <CAGXu5jJChvx-_E8RMTi3ioUZGuQGViy6gcAMpmvYZzms=zc6dQ@mail.gmail.com>
In-Reply-To: <CAGXu5jJChvx-_E8RMTi3ioUZGuQGViy6gcAMpmvYZzms=zc6dQ@mail.gmail.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Thu, 25 Apr 2019 10:11:20 -0700
X-Gmail-Original-Message-ID: <CAGXu5jLoOJydOOxmmiYYL2k_0K-MOD6j=gV8_4BUNhTTyWNsVQ@mail.gmail.com>
Message-ID: <CAGXu5jLoOJydOOxmmiYYL2k_0K-MOD6j=gV8_4BUNhTTyWNsVQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/8] selftests: Move test output to diagnostic lines
To:     shuah <shuah@kernel.org>, Joe Perches <joe@perches.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Christian Brauner <christian@brauner.io>,
        Tycho Andersen <tycho@tycho.ws>,
        Serge Hallyn <serge@hallyn.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 25, 2019 at 10:05 AM Kees Cook <keescook@chromium.org> wrote:
> WARNING: Misplaced SPDX-License-Identifier tag - use line 1 instead
> #37: FILE: tools/testing/selftests/kselftest/runner.sh:2:
>  # SPDX-License-Identifier: GPL-2.0
>
> This is a shell script. It can't be on line 1:
>
> $ head -n3 tools/testing/selftests/kselftest/runner.sh
> #!/bin/sh
> # SPDX-License-Identifier: GPL-2.0
> #
>
> That looks like a bug in checkpatch not resetting the expected line or
> something.

It doesn't like patch 3 and doesn't notice that diff offset starts at line 2:

diff --git a/tools/testing/selftests/kselftest/runner.sh
b/tools/testing/selftests/kselftest/runner.sh
index e1117d703887..f12b0a631273 100644
--- a/tools/testing/selftests/kselftest/runner.sh
+++ b/tools/testing/selftests/kselftest/runner.sh
@@ -2,17 +2,20 @@
 # SPDX-License-Identifier: GPL-2.0
 #
 # Runs a set of tests in a given subdirectory.
+export KSFT_TAP_LEVEL=1

Joe, looks like the problem is here:

                if ($realline == $checklicenseline) {
realline == 2, checklicenseline == 1
so this is skipped, including the "#!/" check to move checklicenseline to 2.
then:
                if ($realline != $checklicenseline &&
                    $rawline =~ /\bSPDX-License-Identifier:/ &&
realline == 2, checklicenseline == 1
throws warning.

Seems like checklicenseline should be unconditionally set to 2 for
".sh" files? I don't see a way to fix this for just missing the #!/
line from a context diff, though...

-- 
Kees Cook
