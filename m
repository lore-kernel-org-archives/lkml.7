Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B369DC3A589
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 17:28:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BACC2064A
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 17:28:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="elMBytnS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730330AbfHOR2m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 13:28:42 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:39236 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726203AbfHOR2m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 13:28:42 -0400
Received: by mail-ot1-f65.google.com with SMTP id b1so7162964otp.6
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2019 10:28:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=L0GqPPZ3ptyjBkt7aBOY+B9eZEmSOFdqgFUkWXmTO1k=;
        b=elMBytnSkJObtOhpcJ7Xs6NSK2Zels7ZXnuvJKtDo7E/y+sRTtehbpYEgdfEqVVQAe
         KqeV+Z/+6xSDjCkXSbhKtJON1HD6dEg1WDp7qu0NyKIMHY5WsaUDYZlEZacJsR4pyi8Q
         pPMcC4GNOtrTkW3MLpbzTNHtf+c/XjrlNS7OteTSuWtNE6x+0XFsOYDqGE+Qy89vO/b5
         ciRfccITYue+8mjdkhKDrJAbD+tZMNI/plcncKU6yK+YbrNSQdoX/jyJ+qIIAYeUHtSk
         lBVKTMSqji4XkczEOouA5UsRHjFT2PCvgxarNlqjY80Dk52+BQLUJpFREPWdLB8oxDiO
         GLxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=L0GqPPZ3ptyjBkt7aBOY+B9eZEmSOFdqgFUkWXmTO1k=;
        b=X+B0289ohiS3yWLwX6uKar5KhyLWEC6UtFBJxAny+hfZ7PzaOxq4rcVC3x7CQXsfUa
         4lFwkUuxytvUZD29IAdc+DP7kJGH6/zGzEKbM2pCyeswL+6KmHSiSxgKkFdNVKt0AV6N
         vBD3hUeBJ7b3POszLZzhLpNWWnIdiPbfQIa9UAoHUB9SZ3FHmRcEZwZON61Pq5KY4ohA
         B5fX6Yr+hqGLpUik3NjT7JtM6qsLxSS5OMJvtfdvPOJONK0W2E1dZmkFLCjqgF1iTGRL
         DG9TPmehUnRkdPzRyTThyxbbd337cr72vs27Q4EOVtLI7kaWVuoPRX8C0I3rbzl/gQw4
         FZ7g==
X-Gm-Message-State: APjAAAXd4ZZRnjhsGI89zyX2U6JW42P6iNZbQPHWHxyMVuZirrPvjo80
        j3H1ne651WuCp9znHlSCgRWcQa+sKvg+vpugBOAoMh3n
X-Google-Smtp-Source: APXvYqyBTBaI9eJbvDjqXYBo8fRWxyThpItUw1gVkcDVt08Xz/Q10OjpEU3cZtbZCeecsS0S9fRvt9+7d9K6qfNXZo0=
X-Received: by 2002:a05:6830:458:: with SMTP id d24mr4109027otc.126.1565890121099;
 Thu, 15 Aug 2019 10:28:41 -0700 (PDT)
MIME-Version: 1.0
References: <20190731111207.12836-1-pagupta@redhat.com>
In-Reply-To: <20190731111207.12836-1-pagupta@redhat.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 15 Aug 2019 10:28:30 -0700
Message-ID: <CAPcyv4gLqd43CLDuGYrDdx4xR1_oc3D0hzdETz8uQmV1C2Dp_Q@mail.gmail.com>
Subject: Re: [PATCH] libnvdimm: change disk name of virtio pmem disk
To:     Pankaj Gupta <pagupta@redhat.com>
Cc:     linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Vishal L Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Keith Busch <keith.busch@intel.com>,
        "Weiny, Ira" <ira.weiny@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 31, 2019 at 4:12 AM Pankaj Gupta <pagupta@redhat.com> wrote:
>
> This patch adds prefix 'v' in disk name for virtio pmem.
> This differentiates virtio-pmem disks from the pmem disks.

I don't think the small matter that this device does not support
MAP_SYNC warrants a separate naming scheme.  That said I do think we
need to export this attribute in sysfs, likely at the region level,
and then display that information in ndctl. This is distinct from the
btt case where it is operating a different data consistency contract
than baseline pmem.
>
> Signed-off-by: Pankaj Gupta <pagupta@redhat.com>
> ---
>  drivers/nvdimm/namespace_devs.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/nvdimm/namespace_devs.c b/drivers/nvdimm/namespace_devs.c
> index a16e52251a30..8e5d29266fb0 100644
> --- a/drivers/nvdimm/namespace_devs.c
> +++ b/drivers/nvdimm/namespace_devs.c
> @@ -182,8 +182,12 @@ const char *nvdimm_namespace_disk_name(struct nd_namespace_common *ndns,
>                 char *name)
>  {
>         struct nd_region *nd_region = to_nd_region(ndns->dev.parent);
> +       const char *prefix = "";
>         const char *suffix = NULL;
>
> +       if (!is_nvdimm_sync(nd_region))
> +               prefix = "v";
> +
>         if (ndns->claim && is_nd_btt(ndns->claim))
>                 suffix = "s";
>
> @@ -201,7 +205,7 @@ const char *nvdimm_namespace_disk_name(struct nd_namespace_common *ndns,
>                         sprintf(name, "pmem%d.%d%s", nd_region->id, nsidx,
>                                         suffix ? suffix : "");
>                 else
> -                       sprintf(name, "pmem%d%s", nd_region->id,
> +                       sprintf(name, "%spmem%d%s", prefix, nd_region->id,
>                                         suffix ? suffix : "");
>         } else if (is_namespace_blk(&ndns->dev)) {
>                 struct nd_namespace_blk *nsblk;
> --
> 2.20.1
>
