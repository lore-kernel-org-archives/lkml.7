Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4501CC32750
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 21:32:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10082205C9
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 21:32:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="kSraaR/B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387800AbfG3Vcy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 17:32:54 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:41011 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726809AbfG3Vcy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 17:32:54 -0400
Received: by mail-oi1-f196.google.com with SMTP id g7so49017731oia.8
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2019 14:32:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=l81RXxL6m1M+gQi+SuAd5R2wSnsgJIHKcsPpxRaT+zY=;
        b=kSraaR/B69E6goTJThqCvMC1ZhsMD0N0w5q1jMLfSN0GHoz9vXAU3m3AHpz+4wmTv9
         tZVIuOs+jj6t6MKaNVnGTZ2VTUi8L/JxKeE0owWWiPnLaW80y1l+DnNHx0apvNfSQYcn
         WmWRi1t5Fnl1S/v5DtX5uqZhbC1jM6F6MFn4Hylizm80YJWY73wGSkEw4N9/Sta7mnMq
         AZZChJkjeOlN5igrm3Ge5gAZg4nniJlq4pAJGB+P2nDXgZ4gduMWAX9ePkqXE2l3g9ry
         OdB63Wq+ER+sZeLgyUEkg7LddjpE89nFO+sdaVyCnc3IDz/7Y67x+Ketii1q7IPt3qHD
         7rAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=l81RXxL6m1M+gQi+SuAd5R2wSnsgJIHKcsPpxRaT+zY=;
        b=CvSLk73yb1BhoZ8QQ+8sqIdP+YghFm60uH+D3YFacOBD4xkS/mVqDUPWNP64GLUdjy
         40U975MEWu0UtCW8hB9hhw1HL1Uwb9Gvdu+WzuPduYkDt5lEKLeyNGwooj/wItZBnu6/
         sUq7br6I2kZvUfdZPfx00WHUvwHq+5llbfLlg9v/D1tY8bI9CzgWRlajgfvGUTH3XikG
         f4rVAjgznyILrGg4OumbJhJWgs7IkszwDsur+lVsN3jyYhBx64C/sNEQRXEpUm3mhBPL
         EdfYgkLwP4QB5oZBbS0VKo0GlhyYu/Bg3T/d6nbZpM+IlrJvPiFinAZwhd47fhuUn5y6
         7qYQ==
X-Gm-Message-State: APjAAAUKufIBtMgHPxS0vhIZuRhEyfa2mInAbxod/kWENBdMp1EYUjwr
        coDdTmiAPiOeCGkAqGg4IVeK/eOMe/1kjji8HohaPQoWt5s=
X-Google-Smtp-Source: APXvYqxegpyFwvFejPXoYEYiHMinVR1/8uYTEPVTdMw6CR76L0x5Au3WV2IYjBoYTv7Ebh0VDCCNGBi0AhckDvlWDPg=
X-Received: by 2002:aca:ba02:: with SMTP id k2mr1920323oif.70.1564522373532;
 Tue, 30 Jul 2019 14:32:53 -0700 (PDT)
MIME-Version: 1.0
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 30 Jul 2019 14:32:42 -0700
Message-ID: <CAPcyv4hJcRY3aop4jgH8NLsz1A8HH7sH6gnGs02Wy8A=p5o=jg@mail.gmail.com>
Subject: [GIT PULL] dax fix for v5.3-rc3
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jan Kara <jack@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus, please pull from:

  git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm dax-fix-5.3-rc3

...to receive a manual fixup I happened to drop. I re-fetched the
patch from the mailing list after integrating the git message-id
support to generate a "Link:" tag [1], but then did not re-apply the
fixup. This now matches what I tested and went into yesterday's -next.

[1]: https://lists.linuxfoundation.org/pipermail/ksummit-discuss/2019-July/006608.html

---

The following changes since commit 609488bc979f99f805f34e9a32c1e3b71179d10b:

  Linux 5.3-rc2 (2019-07-28 12:47:02 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm dax-fix-5.3-rc3

for you to fetch changes up to 61c30c98ef17e5a330d7bb8494b78b3d6dffe9b8:

  dax: Fix missed wakeup in put_unlocked_entry() (2019-07-29 09:24:22 -0700)

----------------------------------------------------------------
dax fix 5.3-rc3

- Fix a botched manual patch update that got dropped between testing and
  application.

----------------------------------------------------------------
Jan Kara (1):
      dax: Fix missed wakeup in put_unlocked_entry()

 fs/dax.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

---

diff --git a/fs/dax.c b/fs/dax.c
index a237141d8787..b64964ef44f6 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -266,7 +266,7 @@ static void wait_entry_unlocked(struct xa_state
*xas, void *entry)
 static void put_unlocked_entry(struct xa_state *xas, void *entry)
 {
        /* If we were the only waiter woken, wake the next one */
-       if (entry && dax_is_conflict(entry))
+       if (entry && !dax_is_conflict(entry))
                dax_wake_entry(xas, entry, false);
 }
