Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07E58C10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 05:10:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD3F0208C3
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 05:10:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ucr.edu header.i=@ucr.edu header.b="qQRAUig6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732797AbfJJFKV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 01:10:21 -0400
Received: from mx2.ucr.edu ([138.23.62.3]:6050 "EHLO mx2.ucr.edu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726518AbfJJFKV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 01:10:21 -0400
X-Greylist: delayed 426 seconds by postgrey-1.27 at vger.kernel.org; Thu, 10 Oct 2019 01:10:18 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=ucr.edu; i=@ucr.edu; q=dns/txt; s=selector3;
  t=1570684220; x=1602220220;
  h=mime-version:from:date:message-id:subject:to;
  bh=pQsPO+s+a3PgY5D8E1xj+ga8C5+DTSwnG2XjsOjt7mI=;
  b=qQRAUig6uYCeheJWIuWEb2NBFoNv5aXcgrX62KkJqXI9uyjaO0+pTmWg
   R+WegWEXtSxQRsJWeRMIHtOBevSI55xuqcL1pT9jMOJH9rYHJH+g5mcfZ
   DvIBaiIPBI+/chWQ6Z8mWY16Z0btq31+oUiJbZ8r/Qwt+fF0uxh5XQuB6
   c9WAsUwXaL4QZkSFXh/TZDky56SgX33FCTxyku5PKI1QeLQhPS1ts3wXk
   rj64J8SgoxkftxuBB3pqNIUEx39FvXr2ePSX8eTigXoDo41MaEGsrNkFE
   Oy0xaOnvhzwNTjmbnWxQdTzDK5mKpEVBg/IFRWvhQfYCNqretyqizk8LN
   g==;
IronPort-SDR: NxCbwf052UUoEjXLfRfL4s6mxtPy0txup7A3pIneRDqQimYwCsddmi48sXUEbb4g9hfG9JLfRl
 cHELsnXbTqrL3frsLdxUKv81/BXuZYU9o2PEl/ErDULGs/YfISGGF7Ew+YxVtyc8wQWNXU3OXZ
 W7OSJlG+Ynes7VZ7Gt/lflhPJyJahc4U6VUWkpBcHDp/1iV1OEiIYCGFUxJJp/Ql9VF/0+9jTj
 WMcPiaCr0yUTB2LEeL8JKR5zuxdTGhx43b0Qpq7JmEkirr15ODblYIaf6W2VwPIw523vgLlSSk
 dNU=
IronPort-PHdr: =?us-ascii?q?9a23=3AYAawzR0JL1VqX7qQsmDT+DRfVm0co7zxezQtwd?=
 =?us-ascii?q?8ZsesXIvTxwZ3uMQTl6Ol3ixeRBMOHsqkC1bCd4vqocFdDyK7JiGoFfp1IWk?=
 =?us-ascii?q?1NouQttCtkPvS4D1bmJuXhdS0wEZcKflZk+3amLRodQ56mNBXdrXKo8DEdBA?=
 =?us-ascii?q?j0OxZrKeTpAI7SiNm82/yv95HJbAhEmTSwbalzIRmoogncstcaipZ+J6gszR?=
 =?us-ascii?q?fEvmFGcPlMy2NyIlKTkRf85sOu85Nm7i9dpfEv+dNeXKvjZ6g3QqBWAzogM2?=
 =?us-ascii?q?Au+c3krgLDQheV5nsdSWoZjBxFCBXY4R7gX5fxtiz6tvdh2CSfIMb7Q6w4VS?=
 =?us-ascii?q?ik4qx2UxLjljsJOCAl/2HWksxwjbxUoBS9pxxk3oXYZJiZOOdicq/BeN8XQ3?=
 =?us-ascii?q?dKUMRMWCxbGo6zYIsBAeQCM+hFsYfyu0ADrQeiCQS2GO/j1iNEi33w0KYn0+?=
 =?us-ascii?q?ohCwbG3Ak4Et0MsXTVrdX1NLoVUeuoz6bIzS/Mb/JL0jr66InJcxAhruuNXb?=
 =?us-ascii?q?5sbcbcx1IiFx7ZgVWKs4DqIS6a1vkUvmWd8uFuVvqvhnY5pw1tpjWj3MQhh4?=
 =?us-ascii?q?nTio4Iy13J9z91zYQoKdC+VUV1e8SrEIFKuCGfL4Z2R8QiTHx2tysi0b0GvI?=
 =?us-ascii?q?K7fDANyJQ62x7Tc/yHfJaM4hLkTOuRJC13hHNheL6mgxay/1WsxvTyVsS2zV?=
 =?us-ascii?q?pGtCVFkt7LtnAC0xzc9NKLRed6/kekwTqP1gbT5f9YIU0si6bXN5oszqQzm5?=
 =?us-ascii?q?cTq0jPAy77lUfsgKKUa0ko4u2o5P7mYrXiqJ+cLYh0igTmP6Uum82/Af43Mg?=
 =?us-ascii?q?kSU2SH9+mxz6Dj8lHjQLlQkPI5j7TZvIjAJcsHvq65HxNV0oE75ha7Djem1s?=
 =?us-ascii?q?kYnHYeIFJGZh2HlY7pNE/KIP3jE/e/jEqjkC1xy/DFILLhGJPNIWbHkLv7er?=
 =?us-ascii?q?Z98UFcm0IPyoV2459EQp0MPfnzV1W54NXcAw8wNQC52aDrBch21o4EcWuKDu?=
 =?us-ascii?q?mSN6aE9Rej5vguOPWNbYkim6j7Kvdts/Xul34ihV4Ue++q2pYRaX+QF/FqZU?=
 =?us-ascii?q?6eZCyoyp0tGHkLskJ+Z+z3jniDVzESL0SyWL92rmUXAZynAd6FdICqnZSI2S?=
 =?us-ascii?q?v9FZpTMCQOJlmSEHugXoSeX/YBIHabI9VlkzEIfbygTZIxkxCj4kuy57NhL+?=
 =?us-ascii?q?fQshMVqY7uzpAh6+TVlBw23TJ6EMCZlWqNGSU8pWoNDwU/wqZ1plZyggOY2K?=
 =?us-ascii?q?1QmfVGE9ZU/fwPVR01Y9qU4vJzDZjLRwvHNoOEVl+gBMy7CDcZR9c9hdQJZh?=
 =?us-ascii?q?A5U/erhROL7yujBPdBtbWAB9oE86vb93H0K4B2zHOQkOEoilVjTcVfHWmnnb?=
 =?us-ascii?q?JksQbJCoPFnl6ai6GyM6MG02qF+H2CiGaDokxceApxSrneG34Fa0baoM/6+k?=
 =?us-ascii?q?TaCbi0BvBvNgpH1N7HKaZQbNDtpUtJSe2lO9nEZW+13WCqClLA9LONfZfsM1?=
 =?us-ascii?q?wc1SOVXFoEkhEO+2+uPhN4Gyy75W/SEWoqXXnvbkXj4PQ2k3S9QQdgxBqNaU?=
 =?us-ascii?q?JJ3KHz5xUPw/GQVqVA8KgDvXIQqid0AVH17dLfCpLUthhhdaQEOYgV/Vxdk2?=
 =?us-ascii?q?/VqloubdSbM6l+iwtGIExMtET02kAyU90YnA=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2FRAwDwvJ5dh0enVdFlDhABCxyGDIR?=
 =?us-ascii?q?NjluFFwGNaYo0AQgBAQEOLwEBhxgjOBMCAwkBAQUBAQEBAQUEAQECEAEBAQg?=
 =?us-ascii?q?NCQgphUCCOikBg1URfA8CJgIkEgEFASIBGhqDAIJ4pDuBAzyLJoEyhAsBAYR?=
 =?us-ascii?q?bAQkNgUgSeiiMDoIXgRGLIoJeBIE5AQEBlS+WVwEGAoIQFIxUiEUbgioBlxW?=
 =?us-ascii?q?OLZlPDyOBRoF7MxolfwZngU9PEBSBaY1xBAFWJJFLAQE?=
X-IPAS-Result: =?us-ascii?q?A2FRAwDwvJ5dh0enVdFlDhABCxyGDIRNjluFFwGNaYo0A?=
 =?us-ascii?q?QgBAQEOLwEBhxgjOBMCAwkBAQUBAQEBAQUEAQECEAEBAQgNCQgphUCCOikBg?=
 =?us-ascii?q?1URfA8CJgIkEgEFASIBGhqDAIJ4pDuBAzyLJoEyhAsBAYRbAQkNgUgSeiiMD?=
 =?us-ascii?q?oIXgRGLIoJeBIE5AQEBlS+WVwEGAoIQFIxUiEUbgioBlxWOLZlPDyOBRoF7M?=
 =?us-ascii?q?xolfwZngU9PEBSBaY1xBAFWJJFLAQE?=
X-IronPort-AV: E=Sophos;i="5.67,279,1566889200"; 
   d="scan'208";a="14127050"
Received: from mail-lf1-f71.google.com ([209.85.167.71])
  by smtp2.ucr.edu with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 09 Oct 2019 22:09:59 -0700
Received: by mail-lf1-f71.google.com with SMTP id t84so1053659lff.10
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2019 22:09:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=GIIH2P83q/mX3xh3maQPqHlz4QJ+Z9HFyeC3gCwbPig=;
        b=Pm/FUdFzN9G5DRYxxybBJBQZ7qYWLyW3avGckQKi2iumWsF5KxMdHngLE2Ia0B1XUX
         FIY8ueZhwYCUD4MKxPXVxMX6nzeIzSY06S+Eas+c16CfXjxRjcz7cQZz9QFV87qxKDew
         d7qSYvMTBroARmLnrJ2nVWnzMnXTHv1744bXBbqzjCSeUkayWiVUyVgwe+5XdhupDbbi
         +CG8m4ij49Qo6n3sP8Zqv3aWa9oQDpn9yZg3mlU2IJLeW/vAJomTJoMPkDPNapU04gcd
         Nd71jyL+X2oGT79oMp5QUMrVHlLNaKLAvbrDqcZ6eboviVWXsFEusrIsD1ozhRvLeSCw
         Nj1Q==
X-Gm-Message-State: APjAAAUNm84+02wEWDEbus1yUKHdAF9QrGk5LbTsT6ZJkBqHJlzgdueA
        vJp8u1gqRALCaXVqa/edWIw6vtsfRW7eCjoLEr60ezhyAto7PMxE5Bdk/zN3f2edHMXPrOlK8fT
        aMlWaO+pF7NQRMWXBnoUF2BczJjZpY/J1Z9re2X08UQ==
X-Received: by 2002:a2e:6a04:: with SMTP id f4mr4795053ljc.97.1570684198370;
        Wed, 09 Oct 2019 22:09:58 -0700 (PDT)
X-Google-Smtp-Source: APXvYqx4+Ag+0zjeb2o0SrDvuaa8jOaPuDPdyg3zpbOVtTOkjtWQ+gGvmWw+7mH9RDBzjC8jtfHcYs2qafTJb+Kg2A8=
X-Received: by 2002:a2e:6a04:: with SMTP id f4mr4795013ljc.97.1570684197726;
 Wed, 09 Oct 2019 22:09:57 -0700 (PDT)
MIME-Version: 1.0
From:   Yizhuo Zhai <yzhai003@ucr.edu>
Date:   Wed, 9 Oct 2019 22:09:32 -0700
Message-ID: <CABvMjLQuxeZnRMV0T5VDeEj7zV7mD4wzp5QPFCJ_oVhH0vRihQ@mail.gmail.com>
Subject: Potential NULL pointer deference in drm/amdgpu
To:     Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sam Ravnborg <sam@ravnborg.org>, Evan Quan <evan.quan@amd.com>,
        Jack Xiao <Jack.Xiao@amd.com>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Zhiyun Qian <zhiyunq@cs.ucr.edu>,
        Chengyu Song <csong@cs.ucr.edu>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All:
drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c:
The function to_amdgpu_fence() could return NULL, but callers
in this file does not check the return value but directly dereference it,
which seems potentially unsafe.
Such callers include amdgpu_fence_get_timeline_name(),
amdgpu_fence_enable_signaling() and amdgpu_fence_free().


-- 
Kind Regards,

Yizhuo Zhai

Computer Science, Graduate Student
University of California, Riverside
