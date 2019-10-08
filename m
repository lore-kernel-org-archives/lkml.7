Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C175C10F14
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 20:32:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 198C421835
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 20:32:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ucr.edu header.i=@ucr.edu header.b="Si9beN4r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730909AbfJHUcH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 16:32:07 -0400
Received: from mx1.ucr.edu ([138.23.248.2]:32159 "EHLO mx1.ucr.edu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730787AbfJHUcG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 16:32:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=ucr.edu; i=@ucr.edu; q=dns/txt; s=selector3;
  t=1570566726; x=1602102726;
  h=mime-version:from:date:message-id:subject:to;
  bh=Ov+TaJEUL5MZ2MuVlEdFPUX9o96HuIazEg8XGXB2Y+Y=;
  b=Si9beN4r2hb+ZeCjuisQzkxAtApPV29gP3HKWLbOBThddnGfBg0BWGbw
   22RWV0jtWmYVi6LzqaVVQvH1mzRj3SO9XyL8rurtvuodhtPQNb1JyjPVs
   DrmVf+TqZdjvhM8BppPtw4T8jH5llc7NfxGlUr96mlri6h4mtwg9PtBJh
   RioBRkuAEe2O0ul4lxcST9GippuKAxl/GhEuLcy21efCsu32BMex4O6h0
   goRt7TTe9W5yaP8ItdKTpZBUpipTurCW+NqUUASrXyTc0ZFV079Wu+x9b
   eP5K7JiNqEFmGe0+rMOOgHGk5krh5x9xZLzc4GB4BvObChE3gJcbhErRb
   w==;
IronPort-SDR: GAinxH1N2M3SwjwS0AitUWy0vrnK/QypkxI6gpGvSiLSe8I4AURSXGw4CcIVHoTbbOq5koupat
 CyN38ZUXrrz18yYprZ/ddtJ/jt3tcYP/7MnUcbWt87HjThGkZLRPtn50L31+qCnYwn2mqliwAN
 tODgLU8tiqRDN8AssVzWHhmNe48dOUv6UFpGgxWvJUTIz5gWcNQYJxl9TNLTfeShrrIVcTkwZR
 w7Y4977esZeIt2VDj+ahbtx3h9RvtVxTIl4FJkOMqlW/h1vuxII9DEmgXZygLEDv6Ui3AcvBhq
 Khs=
IronPort-PHdr: =?us-ascii?q?9a23=3AZaGBGRKunnS3ZODb79mcpTZWNBhigK39O0sv0r?=
 =?us-ascii?q?FitYgeIvTxwZ3uMQTl6Ol3ixeRBMOHsqkC1rud6v25EUU7or+5+EgYd5JNUx?=
 =?us-ascii?q?JXwe43pCcHRPC/NEvgMfTxZDY7FskRHHVs/nW8LFQHUJ2mPw6arXK99yMdFQ?=
 =?us-ascii?q?viPgRpOOv1BpTSj8Oq3Oyu5pHfeQpFiCezbL9oLBi7qQrdutQWjId/N6081g?=
 =?us-ascii?q?bHrnxUdupM2GhmP0iTnxHy5sex+J5s7SFdsO8/+sBDTKv3Yb02QaRXAzo6PW?=
 =?us-ascii?q?814tbrtQTYQguU+nQcSGQWnQFWDAXD8Rr3Q43+sir+tup6xSmaIcj7Rq06VD?=
 =?us-ascii?q?i+86tmTgLjhTwZPDAl7m7Yls1wjLpaoB2/oRx/35XUa5yROPZnY6/RYc8WSW?=
 =?us-ascii?q?9HU81MVSJOH5m8YpMAAOQBM+hWrJTzqUUSohalGQmgGPnixiNUinPq36A31f?=
 =?us-ascii?q?kqHwHc3AwnGtIDqHbbrNT0NacSTOC1y7TDwjbDb/xM2Df29Y/FcxAgoPGMR7?=
 =?us-ascii?q?1wcNbdxVUhGg7ek1WftZblMymL2esQrmiW9uxtXv+shW4/swx9vCSjy8M2ho?=
 =?us-ascii?q?TKho8Z0E7I+Tl6zYovONG1TE12bNi5G5VKrS6aLZF5QsY6TmFtvyY116MJtI?=
 =?us-ascii?q?agfCgP1JQn3xnfa+Gbc4SQ4hLsSuKRITBgiXJgYr2/hhKy/VGkyu3+S8W4yV?=
 =?us-ascii?q?hKojdBn9TPrHwN2BvT6s+ISvt54EitwyqA1wfW6u1cIEA0k7TUK4I5z7Iuip?=
 =?us-ascii?q?YetV7PEyz2lUnskqOaakYp9vK15+njYbjqvpqcOJV1igH6PKQugMu/AeEgPw?=
 =?us-ascii?q?kOXmmb+f6z1Lz/8UHlTrhHleA2nbXDsJzAO8sUu7O5DxdP0ok/8xa/Eyum0N?=
 =?us-ascii?q?MAkHkDLVJFfg+HjofwN1HNPv/4F/G/jEqokDpw2fDGMaPuAo/XInjAjrjhZ7?=
 =?us-ascii?q?B95FBYyAYpytBf/Z1UWfk9J6fZU1XtsNvdDxI7ez6zx+DmBc9+144BWGmdSv?=
 =?us-ascii?q?uTdrHVtVmJ6/gsIuSkf4YQoyv7JL4u4Pu4yTc1g15YcaS30J8/bHGjAu8gLV?=
 =?us-ascii?q?+UbHbhmdQdFn9MuRAxCKTuiVufQXtdbXq/QYoi6TwhToGrF4HOQsaqmrPFlC?=
 =?us-ascii?q?O6GIBGI2NLEFaBFV/2eIieHfQBciSfJolmiDNXe6KmTtoQ1AOuqQiy+bpuL6?=
 =?us-ascii?q?KA6z8YvJO7jINd+ubJ0xw+6GonXIymz2iRQjQszSszTDgs0fU6+BQlxw=3D?=
 =?us-ascii?q?=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2EcAwD98Jxdh8bQVdFmgkGEEIRNjmG?=
 =?us-ascii?q?FFwGGeIZxiDmBewEIAQEBDi8BAYcIIzYHDgIDCQEBBQEBAQEBBQQBAQIQAQE?=
 =?us-ascii?q?BCA0JCCmFQII6KQGDVRF8AwwCJgIkEgEFASIBNIMAgguiF4EDPIsmgTKIZgE?=
 =?us-ascii?q?JDYFIEnoojA6CF4Rhh1KCWASBOQEBAZUvllcBBgKCEBSMVIhFG4IqAZcVji2?=
 =?us-ascii?q?ZTw8jgTYDgggzGiV/BmeBT08QFIFpjkwkkUQBAQ?=
X-IPAS-Result: =?us-ascii?q?A2EcAwD98Jxdh8bQVdFmgkGEEIRNjmGFFwGGeIZxiDmBe?=
 =?us-ascii?q?wEIAQEBDi8BAYcIIzYHDgIDCQEBBQEBAQEBBQQBAQIQAQEBCA0JCCmFQII6K?=
 =?us-ascii?q?QGDVRF8AwwCJgIkEgEFASIBNIMAgguiF4EDPIsmgTKIZgEJDYFIEnoojA6CF?=
 =?us-ascii?q?4Rhh1KCWASBOQEBAZUvllcBBgKCEBSMVIhFG4IqAZcVji2ZTw8jgTYDgggzG?=
 =?us-ascii?q?iV/BmeBT08QFIFpjkwkkUQBAQ?=
X-IronPort-AV: E=Sophos;i="5.67,272,1566889200"; 
   d="scan'208";a="13033644"
Received: from mail-lj1-f198.google.com ([209.85.208.198])
  by smtp1.ucr.edu with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 08 Oct 2019 13:32:05 -0700
Received: by mail-lj1-f198.google.com with SMTP id y12so4529562ljc.8
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2019 13:32:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=Y5uvD0KVI1iYImauUvxo4V9KaiRqMOMx+KR5+x6L9WM=;
        b=Kh/PPJQjwE0ZFUZSrO6UuP3bOREVYiYfHnCc8U0TgrmHBCVk2d2QJjfumLmYoYJ4C+
         CZULpgcSBeoH/sFV0U3/Ad7tqWEvRlofaZI3wuAJcHFv0LRWsZmB6YduBJ/dpnMjwkzI
         BbVuA6k9vBn8SzrO4Ley4nyWaCeCzjxM9EfhIAQeB7rwmD+s6zkpHqElYJO+662XXOOa
         RKtEDUy8wfmFHCcyBQWL3cwU6D8yQLoyVJz76hqB6dmC3y/uQufjaDgVmB7D+QV5DTqJ
         ++dozIFNYqS1vJLcqqwj+IqrWQl/5G8BI6WAsa88aucuatB5jynzCKtGtyLt2+qlI3Vv
         uNnw==
X-Gm-Message-State: APjAAAX+m4Qa/q+x3kJyPpXCyQust79mfAHHrk+DDWWg74YyC3ESlZmH
        /lkZs+rcQexZdmPDrMG5UESyoPt+zgnUdUITpKodQjnBlVaGH+dl9nil4CSSPQWb+kJjDk/sxUw
        fwWXgClSENAQvfNhXO06YrCdfTKE1/q7O3U0lCokioA==
X-Received: by 2002:ac2:44d2:: with SMTP id d18mr22257162lfm.67.1570566723360;
        Tue, 08 Oct 2019 13:32:03 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzKXb5GhB8uOBl0EocLC+TY8jhaYV0Q9PE/EonJZ2i5JDTwYHHUoHWPpSFGT7Ou1l0SIUv9Vaan38rSSzyLys0=
X-Received: by 2002:ac2:44d2:: with SMTP id d18mr22257148lfm.67.1570566723127;
 Tue, 08 Oct 2019 13:32:03 -0700 (PDT)
MIME-Version: 1.0
From:   Yizhuo Zhai <yzhai003@ucr.edu>
Date:   Tue, 8 Oct 2019 13:32:45 -0700
Message-ID: <CABvMjLRE_Nxa1jC1o9uw_jsuAABdm+nE0ZNu-yh0hMzmfqEr_g@mail.gmail.com>
Subject: Uninitialized Variable Use in video: fbdev: pm3fb
To:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All:

drivers/video/fbdev/pm3fb.c:

Inside function pm3fb_write_mode(),  variable "m" "n" "p" could leave
uninitialized after pm3fb_calculate_clock(), however, they are used
later in PM3_WRITE_DAC_REG, which is potentially unsafe.


-- 
Kind Regards,

Yizhuo Zhai

Computer Science, Graduate Student
University of California, Riverside
