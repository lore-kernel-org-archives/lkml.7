Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E730C4360C
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 04:52:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34D862133F
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 04:52:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ucr.edu header.i=@ucr.edu header.b="tYfXXNim"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387974AbfJDEws (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 00:52:48 -0400
Received: from mx5.ucr.edu ([138.23.62.67]:6086 "EHLO mx5.ucr.edu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387754AbfJDEwr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 00:52:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=ucr.edu; i=@ucr.edu; q=dns/txt; s=selector3;
  t=1570164767; x=1601700767;
  h=mime-version:from:date:message-id:subject:to;
  bh=ql44aBwf8muduY7E8woRGM6sMLEeHBMPetACIWQG9tI=;
  b=tYfXXNimHkCNHsyoffV/3Hm5PI6UMh42xeVytaqAH36m2ZlyCO+vsCGb
   9Z2EXlNm+SEg0LESIDkIavkm5Y2ul61B643Eb9oYp2WRbfphseoZ4LJYq
   2o5FAvjRBZDq9Rz0XAf8TXFlEWWdYDqt2QZ0q9/u+nkh7pOKpuUqRVR4i
   qw3X+jug4ifD4twUkBe5cVOJ0Kkte+1hjvKP4vIkKebhI6pHJWMd5c7Hg
   k66ZnokVo2fXDVDsKYTFs/nq8vBErEYxMTk/FXAy0uyf6PgnGkygA5eii
   7HijAZ8peFSUDFYGN5L+7lMGVN/POTcyTQ9zQ1TI4S3QqgkWIy6tyu/x2
   Q==;
IronPort-SDR: x2QnU8Nj+HGf8pjDtplMv7RnOk4dvdCsWAwMuDXLVErzGOfmbPUH529fmp9skY0TldsmIuMIj/
 9v693YYqgditkOSXRriyM+y80EWmCw1pz+Trazn3qL6gc6fq7p1QkAc8j0/N1l96ELRfruufW6
 z3XlVwx86AtEEF5i+64ylXPE4JNMOdhfd9kbMIOlIV5Hd3Z61a+W57FSCh4VBOHdOVSTzOIgjC
 gBT3Tbx6kXCnA4InKVPAHuAsGa0fvk05BZD+klTpOyGuNs0xiq8IvBW/7XPY0sP9bIV9ai7ekV
 ydI=
IronPort-PHdr: =?us-ascii?q?9a23=3AsYHajxV67iedE/Ezvv72XobOXXvV8LGtZVwlr6?=
 =?us-ascii?q?E/grcLSJyIuqrYZRWBv6dThVPEFb/W9+hDw7KP9fy5Aipdud3b6zgrS99lb1?=
 =?us-ascii?q?c9k8IYnggtUoauKHbQC7rUVRE8B9lIT1R//nu2YgB/Ecf6YEDO8DXptWZBUh?=
 =?us-ascii?q?rwOhBoKevrB4Xck9q41/yo+53Ufg5EmCexbal9IRmrowjdrMkbjZdtJqovxB?=
 =?us-ascii?q?bCv2dFdflRyW50P1yYggzy5t23/J5t8iRQv+wu+stdWqjkfKo2UKJVAi0+P2?=
 =?us-ascii?q?86+MPkux/DTRCS5nQHSWUZjgBIAwne4x7kWJr6rzb3ufB82CmeOs32UKw0VD?=
 =?us-ascii?q?G/5KplVBPklCEKPCMi/WrJlsJ/kr5UoBO5pxx+3YHUZp2VNOFjda/ZZN8WWH?=
 =?us-ascii?q?ZNUtpUWyFHH4iybZYAD/AZMOlXr4fzqVgAowagCwawH+7v1iNEi2Xq0aEmz+?=
 =?us-ascii?q?gsEwfL1xEgEdIUt3TUqc34O6UTUeG0zKnI0DLDZO5V1jf98ofIcw0qrPaMXL?=
 =?us-ascii?q?Nxccre00gvGx/ZgliesoHlIi+a1v4Xv2eF8uVgSPuihmg6oA9yujii3tkghp?=
 =?us-ascii?q?XNi44PyV3J9T91zJs0KNC6UkJ2Y8KoHZ1NvC+ALYR2WNktQ2RwtSY/zb0JpI?=
 =?us-ascii?q?C0cTARyJQi2x7fc/uHc5WU4h77VOaePzN4hHV9dbK6nRmy8EygxvT4Vsm6zV?=
 =?us-ascii?q?pGtyRFn9vQunwX2BzT7c+HSvR5/ki/wzqAywfT6uRcLUA1k6rUNYIhz6Yump?=
 =?us-ascii?q?YPtUnPBCz7lUXsgKOLd0gp+PKk5ub7brn+o5+TLY50igXwMqQ0ncy/BPw1Mw?=
 =?us-ascii?q?gPXmib4+u81aHv8VH3TbhRk/05jrPZvIrEKssGu661GxVV3Zo76xajEzem18?=
 =?us-ascii?q?wVnX0GLFJDZRKGgJHlO1LQL/DiC/ewnVCsnSx1x/DJILLhGI/BLnvdn7f7e7?=
 =?us-ascii?q?Zy9UpcxBA0zdBF6JIHQo0Gddz6UFXwv9GQIRYiNQ252a6zBtx3zIIVVCSAC7?=
 =?us-ascii?q?SfMa7ImUSUoOkoJr/ILLMVuTvnMelt3fPijHk20QsBfaikx4EGLmq1EvVgLG?=
 =?us-ascii?q?2WZHPthpEKFmJc+kIDU+Hdq1mPUDheIlUsWaMzrmUmToGiAIbFS8Wuh7GH3S?=
 =?us-ascii?q?iTBpBQaX1aEFeKEGeue4jSH78pYTKTJ8IpuTsdSLWlSolpgRSlsxbnxr5mKK?=
 =?us-ascii?q?zP5ihD77rs0dF046vYkhRksXRdC8mN2meBVWw8omQSSCI7lPR2pUFtw1GPy6?=
 =?us-ascii?q?U+n/tCGsFez+hVFAw9MMiYh+h7Dc3iHxree/+XR1u8BNarGzc8SpQ22dBKK0?=
 =?us-ascii?q?J8Hciyywvf2nHwK6QJ0rmHQZk986bZ1n63PNp60XPc2bElnh8tRc4LfWmngL?=
 =?us-ascii?q?NvsgHJAsvKnl+fmqKCcaUHwDWL9WGN12OCsUhUFglqXuGNWXEZe1uTrtnj4E?=
 =?us-ascii?q?7GZ6GhBK5hMQZbz8OGbKxQZZmhv1VHVerlcO3famT5z3WwBAeVwKqkZ5GsZm?=
 =?us-ascii?q?4HmijRFR5A2ysT8HCJJBV2PSCnrCqKBydpE13HaFiq7OJk7n63Uxln4RuNah?=
 =?us-ascii?q?hQ1qi15xldt/yVSrtHz6AEsSZ5825cAV2nmd/aFozT9EJaYKxAbIZlsx983m?=
 =?us-ascii?q?XDulk4Z8T4Ig=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2HgAgBxz5Zdh0anVdFlDhABBhKFRDO?=
 =?us-ascii?q?ETI5fhRcBmBgBCAEBAQ4vAQGEOwOCSiM4EwIDCQEBBQEBAQEBBQQBAQIQAQE?=
 =?us-ascii?q?BCA0JCCmFQII6KQGDVRF8DwImAiQSAQUBIgE0gwCCCwWhWIEDPIsmgTKEDAG?=
 =?us-ascii?q?EWAEJDYFIEnoojA6CF4Nuc4dRglgEgTcBAQGVK5ZSAQYCghEUA4xRiEQbgiq?=
 =?us-ascii?q?XFo4rmUoPI4FGgXszGiV/BmeBT08QFIFbDgmNaAQBViSRewEB?=
X-IPAS-Result: =?us-ascii?q?A2HgAgBxz5Zdh0anVdFlDhABBhKFRDOETI5fhRcBmBgBC?=
 =?us-ascii?q?AEBAQ4vAQGEOwOCSiM4EwIDCQEBBQEBAQEBBQQBAQIQAQEBCA0JCCmFQII6K?=
 =?us-ascii?q?QGDVRF8DwImAiQSAQUBIgE0gwCCCwWhWIEDPIsmgTKEDAGEWAEJDYFIEnooj?=
 =?us-ascii?q?A6CF4Nuc4dRglgEgTcBAQGVK5ZSAQYCghEUA4xRiEQbgiqXFo4rmUoPI4FGg?=
 =?us-ascii?q?XszGiV/BmeBT08QFIFbDgmNaAQBViSRewEB?=
X-IronPort-AV: E=Sophos;i="5.67,254,1566889200"; 
   d="scan'208";a="80568197"
Received: from mail-lf1-f70.google.com ([209.85.167.70])
  by smtpmx5.ucr.edu with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 03 Oct 2019 21:52:46 -0700
Received: by mail-lf1-f70.google.com with SMTP id c83so586702lfg.8
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2019 21:52:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=UonwauBUbF5jJCMbv+kEyggRBo1MYeaIpr/rVjEka4g=;
        b=MTUCZGEzyk+J/v+B9TE3ecGgmg381QXg5UWas6uSk8NRDev57lTZ58yRVy0chC0lHX
         uGjPvy+6nVDIyBK1ntPp8vtKiqEiI3u2oxp2wCajymnui3APjX/cfe7T6ZtOplBaXJBR
         h5Iv3c2HZ9E8kD9lBiZ7pRq4tvVhXwTRrIV9GXOfxgp4YG3bbiMS9nJVsUjiffTNW+4k
         JwJRzr2+JvV/hYhTW4K4zcUmzoBzceM+mMxIDJhq+9UdpaWZQderP+mFHDu9Fe8Fta6p
         mRNNSgmGvSBza2J9/FbcNlfWinaTD32TX2tABJbkxd70c2Lfh36GP1dewreEUqnpzqsT
         YhSA==
X-Gm-Message-State: APjAAAUoAAySAx4gJ7VwngB1tlYb9/IUslaWv3U58zLrqWedXtdht4ru
        tXRMgVkzT/DcCL5pWYrVd1n9M+RfQeaiRYVdt/vzhfDy9VUapPso8OczKX63jvJfez1IGalcNkz
        DzFBfh533sShgDOoSogRZ1FSNy5JZ8u617Y8QCeXHYA==
X-Received: by 2002:a19:4347:: with SMTP id m7mr7417797lfj.146.1570164764938;
        Thu, 03 Oct 2019 21:52:44 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxQwQ4yv8ZIWgEbfBVR+NQnXGTuto6AhZqOSD61PfrwsPbsqTELSWEjRUHKiie8C8KsIwGEinKXPs2u+mEFOfQ=
X-Received: by 2002:a19:4347:: with SMTP id m7mr7417782lfj.146.1570164764695;
 Thu, 03 Oct 2019 21:52:44 -0700 (PDT)
MIME-Version: 1.0
From:   Yizhuo Zhai <yzhai003@ucr.edu>
Date:   Thu, 3 Oct 2019 21:52:31 -0700
Message-ID: <CABvMjLSR9kFJpU19OX8Us4jPQ9vuTtNR571Njn_gqqpb-=hdCQ@mail.gmail.com>
Subject: Potential uninitialized variables in pwm: stm32-lp
To:     Fabrice Gasnier <fabrice.gasnier@st.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        linux-pwm@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Zhiyun Qian <zhiyunq@cs.ucr.edu>,
        Chengyu Song <csong@cs.ucr.edu>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All:

drivers/pwm/pwm-stm32-lp.c:

Variable "val" and "prd" in function stm32_pwm_lp_get_state() could be
uninitialized
if regmap_read() returns -EINVAL. But it's directly used later without
the return check,
which is potentially unsafe.

Also, we cannot simply return -EINVAL in stm32_pwm_lp_get_state() because the
return type is void.

Thanks for your time to check this case.
-- 
Kind Regards,

Yizhuo Zhai

Computer Science, Graduate Student
University of California, Riverside
