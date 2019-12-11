Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24183C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 22:09:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E51E6205C9
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 22:09:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iMwcA6xk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726704AbfLKWI7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 17:08:59 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:44414 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726368AbfLKWI7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 17:08:59 -0500
Received: by mail-ed1-f66.google.com with SMTP id cm12so20791111edb.11
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2019 14:08:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=YBIdEEv7gGHcdelfVnBQWSz2qhfcUktd5CaQIiNmyAY=;
        b=iMwcA6xkOcaqs3dqY/A0sNjdvdxivVLGQNt7pEaww1skLQRv0kII4ccv1xGow9irn+
         jY/pi17fv/VWbtmvDUzgEATKyVzpXPOEzBShsvatAF9y5sJlTA7SXtEz4prGUSgcwPFa
         gJ14ndn7FcYRNf+0N3f3NPX8lyqqAsH+J1XrmR3E8E94ncCxSATcEUoDNcrvl1ue/yS1
         Ww6HGpGz595dAqsRgWH68ENEGx8jxb+HfxP7ESaACUWy5cJy8s5QrDmV1Z0yybatJc2+
         h7wtek+mtPt1S/insrNzRib9ImfhInXXOp5Rb9bEoCF0Tj21Xy8Nosqng3S/9vno6610
         quLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=YBIdEEv7gGHcdelfVnBQWSz2qhfcUktd5CaQIiNmyAY=;
        b=Sp1s26xrWKgRNP/hiIdJ+2NDapIKcEAtI+HvOm3OIvhyYXvA2tXm43PJ5CbDjPZkZR
         kzdeK/54q6K8QwLlxIQVOiotoRAt5N2HJZttenXtAnfHJUMtGk1tiEhxh7uxm9kMYAqB
         MUP0kRiYmlfiR3bjAMUubDbfqDOgZb/kXxHn+EbA79PuhBseb9dtDq4bwoL49045+2iG
         u79bpKdlipCjtzVRqeFFdlBKyfwwnaNr2c+65RV7w744MQndk3Qz/d44LRwC7fQWYJ5Y
         KoObU8hA1h+UH//bxsKl7vmxvVCHgGBlEe+M7VNT02ucAtFh1YKtnDb0beChFYpHvBw8
         DceQ==
X-Gm-Message-State: APjAAAX1kStEIx5pY3YR71Hh2P87dIBLOnGPBiEkTDcOHRL5DRFywDNW
        VIRn05r6B/clGmLwl4ab6aoBK/ToA6Rs7zxghKY=
X-Google-Smtp-Source: APXvYqyCbu8sOfglKhyIDHT2Ca7YYK6HKuS+OO+F4lv060H15xGCpTNN85lpKvGZUXkyZEKggzrXXgxWekga/TDA3H0=
X-Received: by 2002:a05:6402:28d:: with SMTP id l13mr5834331edv.236.1576102137194;
 Wed, 11 Dec 2019 14:08:57 -0800 (PST)
MIME-Version: 1.0
From:   Nicholas Tsirakis <niko.tsirakis@gmail.com>
Date:   Wed, 11 Dec 2019 17:08:46 -0500
Message-ID: <CAFqpmVJ90bAV4vasH1Z0DcTUjT7asCJFPeJBxtxGZwAhTVP7=w@mail.gmail.com>
Subject: [BUG] Xen-ballooned memory never returned to domain after partial-free
To:     boris.ostrovsky@oracle.com, jgross@suse.com
Cc:     xen-devel <xen-devel@lists.xenproject.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

The issue I'm seeing is that pages of previously-xenballooned memory are getting
trapped in the balloon on free, specifically when they are free'd in batches
(i.e. not all at once). The first batch is restored to the domain properly, but
subsequent frees are not.

Truthfully I'm not sure if this is a bug or not, but the behavior I'm seeing
doesn't seem to make sense. Note that this "bug" is in the balloon driver, but
the behavior is seen when using the gnttab API, which utilizes the balloon in
the background.

------------------------------------------------------------------------------

This issue is better illustrated as an example, seen below. Note that the file
in question is drivers/xen/balloon.c:

Kernel version: 4.19.*, code seems consistent on master as well
Relevant configs:
    - CONFIG_MEMORY_HOTPLUG not set
    - CONFIG_XEN_BALLOON_MEMORY_HOTPLUG not set

* current_pages = # of pages assigned to domain
* target_pages = # of pages we want assigned to domain
* credit = target - current

Start with current_pages/target_pages = 20 pages

1. alloc 5 pages with gnttab_alloc_pages(). current_pages = 15, credit = 5.
2. alloc 3 pages with gnttab_alloc_pages(). current_pages = 12, credit = 8.
3. some time later, free the last 3 pages with gnttab_free_pages().
4. 3 pages go back to balloon and balloon worker is scheduled since credit > 0.
    * Relevant part of balloon worker shown below:

    do {
        ...

        credit = current_credit();

        if (credit > 0) {
            if (balloon_is_inflated())
                state = increase_reservation(credit);
            else
                state = reserve_additional_memory();
        }

        ...

    } while (credit && state == BP_DONE);

5. credit > 0 and the balloon contains 3 pages, so run increase_reservation. 3
   pages are restored to domain, correctly. current_pages = 15, credit = 5.
6. at this point credit is still > 0, so we loop again.
7. this time, the balloon has 0 pages, so we call reserve_additional_memory,
   seen below. note that CONFIG_XEN_BALLOON_MEMORY_HOTPLUG is disabled, so this
   funciton is very sparse.

    static enum bp_state reserve_additional_memory(void)
    {
        balloon_stats.target_pages = balloon_stats.current_pages;
        return BP_ECANCELED;
    }

8. now target = current = 15, which drops our credit down to 0.
9. at some point later we attempt to free the remaining 5 pages with
   gnttab_free_pages().
10. 5 pages go back into the balloon, but this time credit = 0, so we never
    trigger our balloon worker (it wouldn't do anything anyway).
11. since we've essentially irreversibly decreased target_pages, we'll never
    attempt to re-add those pages to our domain, and those pages are reserved
    in the balloon forever.
12. this can be verified by running "free", "cat /proc/meminfo", etc. to show
    that the total memory has indeed decreased permanently until host reboot.

Is this desired behavior? Why would we decrease our target pages if there's no
way to restore them? I understand there is a helper function to manually reset
the target, but the caller would need to manually keep track of the starting
pages; that seems like unnecessary maintenance that the balloon should handle.

Additionally, why should any of the above code be possible if we have memory
hotplugging disabled? I'm surprised we are able to balloon any memory out from
the domain in the first place. I would have expected gnttab_alloc_pages to fail.

Please CC niko.tsirakis@gmail.com on any replies. Thank you,

--Niko
