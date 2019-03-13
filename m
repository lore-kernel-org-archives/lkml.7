Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 297E1C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 12:39:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E910D214AE
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 12:39:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dxRhbBjR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726263AbfCMMjl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 08:39:41 -0400
Received: from mail-lj1-f175.google.com ([209.85.208.175]:47028 "EHLO
        mail-lj1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725847AbfCMMjl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 08:39:41 -0400
Received: by mail-lj1-f175.google.com with SMTP id z26so1177298lja.13;
        Wed, 13 Mar 2019 05:39:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:user-agent:mime-version;
        bh=N/qevYiS4eUCg9JB/8s90xDFtnQ8s0Ikd4ShgSO0S3I=;
        b=dxRhbBjRMb1FtEySQtv0yi3p/nIkSektQgkFbJmMvVg8A8UyZCdrYOKBFH9ANMTZj3
         EPDnfaKOldJ6lnIEdFYLDYbsQOUP5JisBZXi/WRigxdWqwoCJIh11zL20A+weaJzQS/9
         O2JcYETLJJ6I7v0N42zt7X6BnPDwXaboQweLcj2ukKRyH3zSasziXi4cl8+VBO0LvQhG
         7N093edk+Bze7F6wWMtJBa0x9VyWtyqkD0xno4/n0x6+h/KQZLy5q/NyNdExs2h5rvVc
         sVK/DfH9H3d//Y4cTD8HK0T+fbzge/6qQL3jhAY7wabYFfLNmi0qO5Wx98UrOr45nhVK
         FFXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:user-agent
         :mime-version;
        bh=N/qevYiS4eUCg9JB/8s90xDFtnQ8s0Ikd4ShgSO0S3I=;
        b=TC8OflykoDEr5N8zwVS3Eh0sMFTsODPuWZ5yU6XhJAap0uLfDZrGfSLbHldVSVrAJu
         Evk27B9NAyjUKao/KnLU3e1C94ZITuFj4nhY9ZhN8R+ziXly9sjc7B/WmCYpZ1HRjulG
         iLFe/ltlA3bot0oPJMSQljlFgG4gS+Cu2rfj56sXhIfRhrUagk59gM1Jp7CjDZzFkRtc
         i7CeylmXDqdVkrcOHGoRa8Ujq0ByIzxLZ4QvTdyNoBSzaEbHtT1ewZck+NKRJs8CvN6A
         54sUiuVnFks/LH0aHqleeK7sfzAqS0cECG+fSMRuvAMKPpd/tuJwvjxVT8smmRJB7zi/
         rijA==
X-Gm-Message-State: APjAAAUfdIfg2hCmjrOrkXG8VVeZ2Oi5ogqC988RRIgAgPpDwVsLTpLx
        LdOQyNj6pjixlHtVNcouJtC/dRWSVNM=
X-Google-Smtp-Source: APXvYqy43oMa7KPK3n4cgCAF3uBokEsPKe0JuSGE0Fcz4IvbTJMlRBuUC7UqJGpiH1t7NE1remIEgQ==
X-Received: by 2002:a2e:9e03:: with SMTP id e3mr3049028ljk.92.1552480778637;
        Wed, 13 Mar 2019 05:39:38 -0700 (PDT)
Received: from linmac2 ([46.138.63.5])
        by smtp.gmail.com with ESMTPSA id g68sm1800908ljg.53.2019.03.13.05.39.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 13 Mar 2019 05:39:37 -0700 (PDT)
From:   moosotc@gmail.com
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: ACPI, software suspend, power consumption, EFI, crashing
Date:   Wed, 13 Mar 2019 15:39:36 +0300
Message-ID: <87ftrrosmv.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

After a "regular" system update (pacman -Syu) new kernel and firmware
packages were installed on this machine[1] (The exact version of the
kernel/firmware may be a red-herring given sporadic and non bisectable
(at this point) nature of the problem)

The system failed to come up after a reboot though. The machine was
dead, being an EFI box meant that it also was silent as to why (no
console output).

After adding "debug earlyprintk=efi,keep log_buf_len=16M"[2] to the
kernel command line (luckily it's quite easy with rEFInd[3]) it became
apparent that kernel was crashing (at least 2 oopses happened during
boot the second one being fatal)

Several false starts later (i.e. downgrade kernel/firmware) when the
system will _sometimes_ boot) the "real" culprit was identified -
another kernel command line parameter _seems_ to play a crucial role:
an empty acpi_osi (i.e. `acpi_osi=`), with acpi_osi removed from the
command line the system (so far) never failed to reach user-space.

But empty acpi_osi was there for a reason, without it the system
consumes 2 watts more while idling (for background cf. [4]) (That said
the acpi_osi influence on power was noticed by accident and is as
inexplicable as the need to do a one-time suspend to memory to achieve
power consumption on par with macOS on this hardware)

It is also worth pointing out that the crashes are not really
deterministic and _sometimes_ kernel boots even with an empty acpi_osi
being present. The non deterministic nature of failures also means
that there is no good "bisection" point for saying this kernel was
okay and after this point in time things went awry.

---------
Update #1
Having `spectre_v2=off' in the kernel command line:

a. Makes the kernel boot even with an empty acpi_osi
b. Makes the suspend-to-memory "trick" effective again
   (in bringing power consumption down)

Update #2 (12-03-2019)
Turns out `spectre_v2=off' is no panacea, just that when it's there
kernel is more likely to complete booting without a hitch

Open questions
--------------

a. How are `spectre_v2=off' and `acpi_osi=' related? (update #2 makes
   this point moot)

b. (Original question from 2016) Why does one-off (accidentally
   discovered) suspend to RAM have any bearing on power consumption?
   And why is the efficiency of this trick dependant on acpi_osi?

   What exactly is so important in clear acpi_osi? (A hypothesis here
   is that AML does (or doesn`t do something "important") depending on
   the acpi_osi value)

[1] https://manuals.info.apple.com/MANUALS/1000/MA1687/en_US/mac-mini-late2014-qs.pdf
[2] After ~10 minutes of excruciatingly slow video redraws
[3] http://www.rodsbooks.com/refind/
[4] https://lkml.org/lkml/2016/2/12/55

-- 
mailto:moosotc@gmail.com
