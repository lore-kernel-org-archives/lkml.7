Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF480C4360C
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 21:18:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9614A21721
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 21:18:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ucr.edu header.i=@ucr.edu header.b="jiVFkVxX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731148AbfJHVSp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 17:18:45 -0400
Received: from mx1.ucr.edu ([138.23.248.2]:35075 "EHLO mx1.ucr.edu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730674AbfJHVSo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 17:18:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=ucr.edu; i=@ucr.edu; q=dns/txt; s=selector3;
  t=1570569525; x=1602105525;
  h=mime-version:from:date:message-id:subject:to;
  bh=7ivXoMVu8s+JtT7SVGYU6lcEvBBmpcUMZbNR5PyOLRg=;
  b=jiVFkVxXXBxd7w1nT73nX00z2hipuPXtmwSWQZR2Sn/8RZCTGSPzRCpR
   QKjPEcmQHW17yuD0qF5ZSlTTksB0V/v4sQ4w06OHNAfbUUUsFvjiMhGb0
   JiCqGmjtiilAKkzxk3gYIa+e3w1xLvq5oUL9mODL6xDnotdqnFkULVyOe
   st+gWooVeA0wBq5CHfFajtTmkrnuLcw33tPOnvy4s36DQ/gfETQv1qO01
   HSWSuTxDCEBx1ptf30A1wMBApx/Rgto2SLNl9xkJwIreuD6qRjoLAwxvd
   rXS4o7w4MHsgbHnPh5vlG1hO1XfoGhbdhKhCEkcxX3Cr7qaOI1KIxwxsb
   A==;
IronPort-SDR: HAPCd9ao4YD9KCDOFvYpq28PW+q+Ih+ACCKt7bekcA/E0lOY6wCmAKspWc96I+YMuhIrI0nrZM
 6tjxe1a0xNsxTrfKbS0YbjikSgACpJS+V/ZjVl3gRBP7NPrQ66Yr8hrS5juaps80DJ5PfDLvHp
 HgeDp1U3pjoX4E6gulc0byOTgzx4/4tKW/H7IJbqjOyKJuio8Kt85E+qfY/fy7eQRwOlLqB9Y/
 YhxX3Npxp3WGUjUKHO4V1DwDID1+C1SO+2lGpHmO6gdp6e725Mlt/QDhF0vjcPI0Ziu3IJvXPe
 xXo=
IronPort-PHdr: =?us-ascii?q?9a23=3AQNMjVhHct1sdRWOGv/2Cl51GYnF86YWxBRYc79?=
 =?us-ascii?q?8ds5kLTJ7yp8qwAkXT6L1XgUPTWs2DsrQY0rGQ7vGrADJZqb+681k6OKRWUB?=
 =?us-ascii?q?EEjchE1ycBO+WiTXPBEfjxciYhF95DXlI2t1uyMExSBdqsLwaK+i764jEdAA?=
 =?us-ascii?q?jwOhRoLerpBIHSk9631+ev8JHPfglEnjWwba58IRmsrQjcssYajZZjJ6os1x?=
 =?us-ascii?q?DEvmZGd+NKyG1yOFmdhQz85sC+/J5i9yRfpfcs/NNeXKv5Yqo1U6VWACwpPG?=
 =?us-ascii?q?4p6sLrswLDTRaU6XsHTmoWiBtIDBPb4xz8Q5z8rzH1tut52CmdIM32UbU5Ui?=
 =?us-ascii?q?ms4qt3VBPljjoMOiUn+2/LlMN/kKNboAqgpxNhxY7UfJqVP+d6cq/EYN8WWX?=
 =?us-ascii?q?ZNUsNXWidcAI2zcpEPAvIOMuhYoYfzpEYAowWiCgS3GOPj1iVFimPq0aEm0e?=
 =?us-ascii?q?ksFxzN0gw6H9IJtXTZtNf6NKYTUOC10anIyijIYPBW2Tjn6YjDbxcsoPGNXL?=
 =?us-ascii?q?Jwa8XRyFUjGx/Lg1iLtIzqIymV2v4TvGeG8uptTOSigHMkpQFpujWj2Nsgh4?=
 =?us-ascii?q?3Tio8Wyl3I7zh1zYc3KNGiSkN3fNipG4ZKuS6ALYt5WMYiTnltuCY917IJp4?=
 =?us-ascii?q?a2fDMPyJQ73x7fbOGHc5SQ7hLjSumRJTB4iWpgeL2lhhay9VGsyunyVsWpyV?=
 =?us-ascii?q?pKoChInsTWunAC0BzT7ceHSv9j8Uu7xTmP0AXT5vlFIUAyi6XbN4YszqAsmp?=
 =?us-ascii?q?cXq0jOHS/7lF/rgKKXdEgo4Oql5/n/brXjvJCcNot0ig/kMqQpn8yyGeQ5Mw?=
 =?us-ascii?q?kOX2eB+OSwyKHv8EPiTbVXkvI2iLPVv47HKsQGvqK5GRNa0p4/6xajCDeryN?=
 =?us-ascii?q?AYnXgBLFJYdxOLlovpNE/UIPD+E/i/h0+hkClkx//YJL3tGJbNIWbZkLfnY7?=
 =?us-ascii?q?l971RQyA0pzdBQtNpoDeQjJ/L6XEn8r5TyAwU2e1i2xObuDtNwzasFWHqUBa?=
 =?us-ascii?q?uELKLVt0TO4O8zda3ELqMcpjfxY8Njr9vviXs0gxVVKaWgw5YSQHyxAPljJ0?=
 =?us-ascii?q?KXfTzqj8tXVS8OvwwjXKn1iUePVTNIfF6sUK8moDI2EoSrCcHEXI/pyLqMwC?=
 =?us-ascii?q?u2ALVIaW1cTFOBC3Hlc8ODQfhIICaTJNJx1z8JT76sT6c/2hy08gz30bxqKq?=
 =?us-ascii?q?zT4CJLm4jk0Y1E5v/TiBZ6xzx9DozJwnONRmAsxjggWjQsmq1zvBoumR+4za?=
 =?us-ascii?q?FkjqkARpRo7PRTX1J/bMaEwg=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2E8AgDR/Jxdh0enVdFmgkGEEIRNjmG?=
 =?us-ascii?q?FFwGWIoF7AQgBAQEOLwEBhwgjNgcOAgMJAQEFAQEBAQEFBAEBAhABAQEIDQk?=
 =?us-ascii?q?IKYVAgjopAYNVEXwPAiYCJBIBBQEiARoagwCCC6IfgQM8iyaBMohmAQkNgUg?=
 =?us-ascii?q?SeiiMDoIXjDOCWASBOQEBAZUvllcBBgKCEBQDjFGIRRuCKpcWji2ZTw8jgTY?=
 =?us-ascii?q?DgggzGiV/BmeBT08QFIFpjkwkkUQBAQ?=
X-IPAS-Result: =?us-ascii?q?A2E8AgDR/Jxdh0enVdFmgkGEEIRNjmGFFwGWIoF7AQgBA?=
 =?us-ascii?q?QEOLwEBhwgjNgcOAgMJAQEFAQEBAQEFBAEBAhABAQEIDQkIKYVAgjopAYNVE?=
 =?us-ascii?q?XwPAiYCJBIBBQEiARoagwCCC6IfgQM8iyaBMohmAQkNgUgSeiiMDoIXjDOCW?=
 =?us-ascii?q?ASBOQEBAZUvllcBBgKCEBQDjFGIRRuCKpcWji2ZTw8jgTYDgggzGiV/BmeBT?=
 =?us-ascii?q?08QFIFpjkwkkUQBAQ?=
X-IronPort-AV: E=Sophos;i="5.67,272,1566889200"; 
   d="scan'208";a="13042995"
Received: from mail-lf1-f71.google.com ([209.85.167.71])
  by smtp1.ucr.edu with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 08 Oct 2019 14:18:44 -0700
Received: by mail-lf1-f71.google.com with SMTP id e1so24429lfb.12
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2019 14:18:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=BzqX1zVw4wq3Gt+nW+YozxJEWLVjzz1XyMCyK/6yVFo=;
        b=bm25J+9e6S0vNn5tUrvtHwCYMCEThbjHCo3vwZyLE9NdTtTFQInbehtyE5zEQWJiJZ
         EdGaZGuMcodObIXABI2Hi1lcMEMn1Sl+NDiY7NCnohy6Ua/NcV+IVHYSLyEI1w1ZhH8c
         +rUFYnUGlrdaa9rjLrEX5jAYV72mgwdHjrYoUQBC0ryeIaN6KZbvUnEKJ5JFidcTC/gK
         NszQjB81CbiWQHkakHa8TzbPYb0X6pdVqC8SZEIMHTFgftut6FmXV+eM3j0+HV/vbCzM
         iKyS8yWoP2lZrxShJ7nIWOWGtzw/c4aSo9SWh4gVtRKJYwHJakJaTopuq8PQ34GSoiWR
         F8Qg==
X-Gm-Message-State: APjAAAUI4QzMe7sZC0tJARtr2NHfM8cToXIvPeep3yz4AgLPpuSbSvzS
        7BGa33qwlnrUUsK557GGfxv3swFFuJF4Mpb6Ez/IVTH9cLATyKVO+W49KbP+OXMcrnGOjSszNA1
        +GB8jg8w2s2yaGQ7uRs0Ow9HO9ryM/0MpYTZ82YoTXA==
X-Received: by 2002:a2e:634e:: with SMTP id x75mr152655ljb.25.1570569521581;
        Tue, 08 Oct 2019 14:18:41 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwxdSHEcSfRKYlPljj5Tuv1lx9cKQ4bNLJxj+P06OlnAhwoDIezvXyKWld7+DEaALP61IUuVX5UPYX+YpMFYDk=
X-Received: by 2002:a2e:634e:: with SMTP id x75mr152642ljb.25.1570569521308;
 Tue, 08 Oct 2019 14:18:41 -0700 (PDT)
MIME-Version: 1.0
From:   Yizhuo Zhai <yzhai003@ucr.edu>
Date:   Tue, 8 Oct 2019 14:19:23 -0700
Message-ID: <CABvMjLQ0Qgzk74yg4quZG4CMKy8pb6pV3XGm_cg4NRkTiCHaKA@mail.gmail.com>
Subject: Potential uninitialized variables in cfg80211
To:     Johannes Berg <johannes@sipsolutions.net>,
        "David S. Miller" <davem@davemloft.net>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All:
net/wireless/chan.c:
Inside function cfg80211_chandef_compatible(), variable "c1_pri40",
" c2_pri40", "c1_pri80" and "c2_pri80" could be uninitialized if
chandef_primary_freqs() fails. However, they are used later in the if
statement to decide the control flow, which is potentially unsafe.

The patch is hard since we do not know the correct value to initialize them.
-- 
Kind Regards,

Yizhuo Zhai

Computer Science, Graduate Student
University of California, Riverside
