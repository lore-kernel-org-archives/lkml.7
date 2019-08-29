Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36435C3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 23:35:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0070F2173E
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 23:35:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="biWGoeyf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727731AbfH2XfN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 19:35:13 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:42120 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727600AbfH2XfM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 19:35:12 -0400
Received: by mail-ot1-f65.google.com with SMTP id g111so2136041otg.9
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2019 16:35:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=w7I+vTCF8MoRhaFpK08T7rrw/DewwWxf4o+4A7aaGhM=;
        b=biWGoeyfg87WAVV9jfzPsO0CvuI+vFgmGePiq3Ubf5qve9suqY4yqgfZnPY8o8Q0iT
         ldqbICZnsF2Z0PcJJv2YH3XLpdVsolvfwJKa93jFo1FNW745Zj62Y68Db8HP69B8yI25
         FhG4qRqeJbCGxQ393M/TXty/F9pEEPrqLGEgDfA3uIL9CbNCSU0hB6KNTZrks1TU3TWB
         N+hF1FIw9xfqtVHhstS7aQVZ8LNPNoJxBZvklZrW/o0fwLvD6NMJO014nVOsKc6jM+1X
         7N27G0dsJ+Vqt3bcnxmg7RIHC0eUgH2lx8ZBSQmf49kc4EMM9HJShs4e9+O7yLgHbDhk
         vFkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=w7I+vTCF8MoRhaFpK08T7rrw/DewwWxf4o+4A7aaGhM=;
        b=n3X7BHdjadyQJ5DM6fqJ7AiMmT4iJqIB+vWwUiiMausoCQokQhPwgrfZsgbS7flgAQ
         0x29AiZCcvA/ayZGAO5o18ixmr/V+em7/2+IQZ9YHaLW7c+2DkNVLDffe1g+CMudjjKk
         54XlVU9P+URVDbo/6qUWWH6Az27deXZvVl+bb0GZbklb620TZLeIvUx8lTNiUs4xDMPg
         g3xZuQgTe/0w8Hzd/p6QvJ4JqEJVq9uxDm5+mx51GrGhqXhfz1YwjcjCgwAS22m6uBau
         cwiDdsPyd99mxe2HfefmarYZdhkNUvZ5rPA0/mT11vvOYMXqAXweQq+So8/CVCopbvbT
         IV/w==
X-Gm-Message-State: APjAAAUHscdG3dNR3YujuncNS41Dyfkyf4x6RWs8/h2yz0Fd4jgcnfN2
        XlgyFUElCYQAzEGpt0bM8CF+XgIFHVVohQqE0keI7w==
X-Google-Smtp-Source: APXvYqyCgFlGZVk6JvnxAvkATHGZWNhCzYn7EP5r7tl1z1c7LpgffQZCiIV9wIvV+Z/O+Cof0dtgknD1/eoqnT+gXWU=
X-Received: by 2002:a05:6830:1e05:: with SMTP id s5mr9416289otr.247.1567121711247;
 Thu, 29 Aug 2019 16:35:11 -0700 (PDT)
MIME-Version: 1.0
References: <156712072444.1601704.7392596435870876837.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <156712072444.1601704.7392596435870876837.stgit@dwillia2-desk3.amr.corp.intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 29 Aug 2019 16:35:00 -0700
Message-ID: <CAPcyv4jGOy+WsdFrPfS9Pr9UiJHrogfdYqUcXxC0GxBsFefpWw@mail.gmail.com>
Subject: Re: [PATCH v2] libata/ahci: Drop PCS quirk for Denverton and beyond
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Stephen Douthit <stephend@silicom-usa.com>,
        Christoph Hellwig <hch@infradead.org>,
        "IDE/ATA development list" <linux-ide@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 29, 2019 at 4:33 PM Dan Williams <dan.j.williams@intel.com> wrote:
>
> The Linux ahci driver has historically implemented a configuration fixup
> for platforms / platform-firmware that fails to enable the ports prior
> to OS hand-off at boot. The fixup was originally implemented way back
> before ahci moved from drivers/scsi/ to drivers/ata/, and was updated in
> 2007 via commit 49f290903935 "ahci: update PCS programming". The quirk
> sets a port-enable bitmap in the PCS register at offset 0x92.
>
> This quirk could be applied generically up until the arrival of the
> Denverton (DNV) platform. The DNV AHCI controller architecture supports
> more than 6 ports and along with that the PCS register location and
> format were updated to allow for more possible ports in the bitmap. DNV
> AHCI expands the register to 32-bits and moves it to offset 0x94.
>
> As it stands there are no known problem reports with existing Linux
> trying to set bits at offset 0x92 which indicates that the quirk is not
> applicable. Likely it is not applicable on a wider range of platforms,
> but it is difficult to discern which platforms if any still depend on
> the quirk.
>
> Rather than try to fix the PCS quirk to consider the DNV register layout
> instead require explicit opt-in. The assumption is that the OS driver
> need not touch this register, and platforms can be added with a new
> boad_ahci_pcs7 board-id when / if problematic platforms are found in the
> future. The logic in ahci_intel_pcs_quirk() looks for all Intel AHCI
> instances with "legacy" board-ids and otherwise skips the quirk if the
> board was matched by class-code.
>
> Reported-by: Stephen Douthit <stephend@silicom-usa.com>
> Cc: Christoph Hellwig <hch@infradead.org>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
> Changes since v1 [1]:
> - Find a way to not duplicate a large portion of the ahci_pci_tbl[]
>   array (Stephen).
> - Add a definition for the PCS register offset rather than hard code
>   (Stephen)
>
> [1]: https://lore.kernel.org/r/a04c0ae7-ef4d-4275-de05-b74beaeef86c@silicom-usa.com/
>
>  drivers/ata/ahci.c |   70 ++++++++++++++++++++++++++++++++--------------------
>  drivers/ata/ahci.h |    2 +
>  2 files changed, 45 insertions(+), 27 deletions(-)
>
> diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
> index f7652baa6337..847e3796d505 100644
> --- a/drivers/ata/ahci.c
> +++ b/drivers/ata/ahci.c
> @@ -65,6 +65,12 @@ enum board_ids {
>         board_ahci_sb700,       /* for SB700 and SB800 */
>         board_ahci_vt8251,
>
> +       /*
> +        * board IDs for Intel chipsets that support more than 6 ports
> +        * *and* end up needing the PCS quirk.
> +        */

Ugh, sorry, I just realized I did not opt Denverton out of this... v3
on the way.
