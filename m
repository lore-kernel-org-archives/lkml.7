Return-Path: <SRS0=vISB=2T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8768CC2D0C0
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 23:36:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 459EE207FD
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 23:36:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577662570;
	bh=6UOsYLI7blF48idHLLHY+ln8Q2c4AWOtQ+muieIlNuM=;
	h=From:Date:Subject:To:List-ID:From;
	b=iM1VHL7akSSHRXqZu5gz7rkBXOzBkZJ952ucyAyDxpGlDCN68EQ440h5UzHCuAXom
	 Qd8iMN8fhmCyWx38rNNw18Ak77n5VPzt7XdBn99XGY1igbRBcvjLg8yKaY5xBYeRNe
	 1QYHb+c/pHhJLwO+BJtOhrp/TdLuCn8tYSS5A3E0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726653AbfL2XgH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Dec 2019 18:36:07 -0500
Received: from mail-lj1-f180.google.com ([209.85.208.180]:43548 "EHLO
        mail-lj1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726119AbfL2XgG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Dec 2019 18:36:06 -0500
Received: by mail-lj1-f180.google.com with SMTP id a13so31768023ljm.10
        for <linux-kernel@vger.kernel.org>; Sun, 29 Dec 2019 15:36:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=83328vbDMhF9ZI2go7mjzobJsYxPsUjRqldOPTSjspY=;
        b=ZzfgkoQ/BhgY6x0i/+FuGDtucysSeUWWeXMFGzQsMsr/QE9F1h/853TrY0lru0NW4H
         tRryGQmtHFX627uvAmrSff723LBXHPzsy2EYF5qsuI4zHRQnbhnQgfBbNeWMIrCEZI8A
         GeokcIqnyGcO53vf7tVk8EQbCVfw/EZ+p15Lg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=83328vbDMhF9ZI2go7mjzobJsYxPsUjRqldOPTSjspY=;
        b=s7NPzL852vNF7LQNjyvf1dCao34anF3Ep4vYZqbQr57dmHGRME/gX/GGdvKDo52Wvk
         Sw6En2cRgNNwj9iCs6PcMJ5MwrZnxrnZZobzRp1mBK2O8AmAsg0KkOyIBLIv1tWxppOk
         W62uAXkHV3crHeNiy4Ox8z/PgSNzZ1X1SwrP2MlgLMOCbVruT8uUMQ5X75xoSKOCOKPw
         opXLlckgCbe/zDymMuS30GZt/EGvJD6SDsvd3NgCNhHpoJJs6lpg3GcNsg0iEFXpcY1d
         UVZyzphtAx7dsZRBS05oQY7KFZOs3fJj95mDMh3Nfgo/R8TPDdV2I40fB9iAZWNr/ZIa
         tsLw==
X-Gm-Message-State: APjAAAW3SyBWE7mRqZ2DeX4o/0Mv39C262xsB2+nnfdeiX5wvI22RjTP
        PooEtXaPZ65NYfq7AosvCzr5f+92LEk=
X-Google-Smtp-Source: APXvYqwKDfTsBNSIPg6Diop5HE6B2rrhkG2Sx1Ka5RbmAKIc3yOTbnpQ+xLWXdB+5xcnw74tIDGgEg==
X-Received: by 2002:a05:651c:204f:: with SMTP id t15mr36998993ljo.240.1577662563525;
        Sun, 29 Dec 2019 15:36:03 -0800 (PST)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com. [209.85.167.48])
        by smtp.gmail.com with ESMTPSA id x84sm17925496lfa.97.2019.12.29.15.36.02
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 29 Dec 2019 15:36:02 -0800 (PST)
Received: by mail-lf1-f48.google.com with SMTP id f15so24120480lfl.13
        for <linux-kernel@vger.kernel.org>; Sun, 29 Dec 2019 15:36:02 -0800 (PST)
X-Received: by 2002:ac2:555c:: with SMTP id l28mr35052058lfk.52.1577662561886;
 Sun, 29 Dec 2019 15:36:01 -0800 (PST)
MIME-Version: 1.0
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 29 Dec 2019 15:35:46 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjq2b9GkLzpaDE-Xryu5c0zMM72BqkJKeZVsX+4ymH6aA@mail.gmail.com>
Message-ID: <CAHk-=wjq2b9GkLzpaDE-Xryu5c0zMM72BqkJKeZVsX+4ymH6aA@mail.gmail.com>
Subject: Linux 5.5-rc4
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To absolutely nobody's surprise, last week was very quiet indeed. It's
hardly even worth making an rc release, but there are _some_ fixes in
here, so here's the usual weekly Sunday afternoon rc.

It's drivers (gpio, i915, scsi, libata), some cifs fixes, and io_uring
fixes. And some kunit/selftest updates. And one or two other random
small things.

Go test it, you still have some time before the New Year's Eve
celebrations commence. Let's all hope for a happy new year, but I
suspect the next rc is going to be on the small side too as most
people are probably still in holiday mode..

                  Linus

---

Amir Goldstein (1):
      locks: print unsigned ino in /proc/locks

Andy Shevchenko (2):
      MAINTAINERS: Append missed file to the database
      gpio: pca953x: Switch to bitops in IRQ callbacks

Arnd Bergmann (9):
      gpio: aspeed: avoid return type warning
      gpio: xgs-iproc: remove __exit annotation for iproc_gpio_remove
      scsi: lpfc: fix build failure with DEBUGFS disabled
      pktcdvd: fix regression on 64-bit architectures
      compat_ioctl: block: handle BLKREPORTZONE/BLKRESETZONE
      compat_ioctl: block: handle BLKGETZONESZ/BLKGETNRZONES
      compat_ioctl: block: handle add zone open, close and finish ioctl
      compat_ioctl: block: handle Persistent Reservations
      PM / devfreq: tegra: Add COMMON_CLK dependency

Chris Wilson (2):
      drm/i915/gt: Ratelimit display power w/a
      drm/i915: Hold reference to intel_frontbuffer as we track activity

Colin Ian King (1):
      scsi: lpfc: fix spelling mistakes of asynchronous

Dan Carpenter (1):
      scsi: mpt3sas: Fix double free in attach error handling

David Abdurachmanov (1):
      riscv: reject invalid syscalls below -1

Florian Fainelli (4):
      ata: libahci_platform: Export again ahci_platform_<en/dis>able_phys()
      ata: ahci_brcm: Fix AHCI resources management
      ata: ahci_brcm: BCM7425 AHCI requires AHCI_HFLAG_DELAY_ENGINE
      ata: ahci_brcm: Add missing clock management during recovery

Geert Uytterhoeven (1):
      gpio: Fix error message on out-of-range GPIO in lookup table

Hillf Danton (2):
      io-wq: remove unused busy list from io_sqe
      io-wq: add cond_resched() to worker thread

Israel Rukshin (1):
      scsi: target/iblock: Fix protection error with blocks greater than 51=
2B

Jens Axboe (7):
      io_uring: use u64_to_user_ptr() consistently
      io_uring: add and use struct io_rw for read/writes
      io_uring: move all prep state for IORING_OP_CONNECT to prep handler
      io_uring: move all prep state for IORING_OP_{SEND,RECV}_MGS to
prep handler
      io_uring: read 'count' for IORING_OP_TIMEOUT in prep handler
      io_uring: standardize the prep methods
      io_uring: pass in 'sqe' to the prep handlers

Johnson CH Chen (=E9=99=B3=E6=98=AD=E5=8B=B3) (1):
      gpio: mpc8xxx: Add platform device to gpiochip->parent

Kent Gibson (1):
      gpio: mockup: Fix usage of new GPIO_LINE_DIRECTION

Leonard Crestez (1):
      PM / devfreq: Drop explicit selection of PM_OPP

Linus Torvalds (1):
      Linux 5.5-rc4

Luc Van Oostenryck (1):
      riscv: fix compile failure with EXPORT_SYMBOL() & !MMU

Mathieu Desnoyers (3):
      rseq/selftests: Turn off timeout setting
      rseq/selftests: Fix: Namespace gettid() for compatibility with glibc =
2.30
      rseq/selftests: Clarify rseq_prepare_unload() helper requirements

Max Filippov (1):
      gpio: xtensa: fix driver build

Nathan Chancellor (1):
      cifs: Adjust indentation in smb2_open_file

Olof Johansson (1):
      riscv: export flush_icache_all to modules

Paulo Alcantara (SUSE) (1):
      cifs: Optimize readdir on reparse points

Russell King (1):
      gpiolib: fix up emulated open drain outputs

Sascha Hauer (1):
      libata: Fix retrieving of active qcs

SeongJae Park (6):
      docs/kunit/start: Use in-tree 'kunit_defconfig'
      kunit: Remove duplicated defconfig creation
      kunit: Create default config in '--build_dir'
      kunit: Place 'test.log' under the 'build_dir'
      kunit: Rename 'kunitconfig' to '.kunitconfig'
      kunit/kunit_tool_test: Test '--build_dir' option run

Shuah Khan (3):
      selftests: filesystems/epoll: fix build error
      selftests: firmware: Fix it to do root uid check and skip
      selftests: livepatch: Fix it to do root uid check and skip

Thierry Reding (1):
      gpio: tegra186: Allow building on Tegra194-only configurations

Tvrtko Ursulin (1):
      drm/i915/pmu: Ensure monotonic rc6

Varun Prakash (1):
      scsi: libcxgbi: fix NULL pointer dereference in cxgbi_device_destroy(=
)
