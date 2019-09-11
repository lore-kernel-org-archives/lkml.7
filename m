Return-Path: <SRS0=Kqgt=XG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0E45C5ACAE
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 18:32:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE1072085B
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 18:32:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PMYQlJr4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730091AbfIKScG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Sep 2019 14:32:06 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:33771 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729867AbfIKScG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Sep 2019 14:32:06 -0400
Received: by mail-lj1-f196.google.com with SMTP id a22so21004449ljd.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2019 11:32:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=osLb1I6IiQ2BmJysQ2eAtNr8jj+efIn6W4VanYf9QGY=;
        b=PMYQlJr4db2/2U22T74KWGNQW5mdUGVyjgpKLcqJfnorAewoVIcQKwl1BzqDNkRD/U
         cxRrYsZ+5fbA2rw3jGvtH6kbMcHDLEQRziuX1fV/qeeviWc9mjeu9Go/K8Q+4BKkOQh3
         fCj8F4eTrGHyzDNZV1KSZaWrXjz7vSLKirSFrboYihd0hx3wGLfZCHqXfmABfpXdyxwL
         hE3YLN0H2HgIbNATx0z0UPk8S/uV2rgr+OrOLuqmPzk48V6NG2h2DjXzFv9AXAv2nk4t
         fIs85Xp7Ik+r6SVG6UZXj8iXV3yt0UYBJtyj28VPO8UmefhkEWY6cChbMI/TuWpR4r53
         Fv3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=osLb1I6IiQ2BmJysQ2eAtNr8jj+efIn6W4VanYf9QGY=;
        b=kv52RLXQDG1IT9mzhS6kCvGbXx467RthhZQu5LFNhRA5lUZQzDX/KV6x81AFQHy6uA
         yZG15CVS1ttEqnvC27ivRZnHKfGLp6xfHu+R+A2uC51TFfHvdBiogdRMB7mLa6F5Na9r
         GklTjrk+IKevvSdaIWXbmLIH+unhMXgyyxM23F6MDJxZJklzE5Z206zlN2R6OZSftuCJ
         YL/uF4phZ/vELKACGVP+aUvgwsQXapy/xW2fRQV3sexhhsAB5di9GaJgSwkFXRfvPGd7
         QcXotEZtCu/wR2jB2pBdLOcrr9zr1E/LtLrv6ZCPW73CjrmLCDL7/yrdMjK04szkwhMb
         pNQg==
X-Gm-Message-State: APjAAAX8Q+KiMiOjQVyxi5uzgGLoXiC4uTufTsxS3qKh6OV3MytWC/JT
        IqxWehuPAvjEvOCqIxAdSQdd8jfqt+pEEYThy5vwhaE=
X-Google-Smtp-Source: APXvYqyCsoJ6mzrOoMT8NBKAi3ATYgRzIfZ1hK0slPZgZIy1MyQ9VeF6irlc5ltIEgvnyeNHUIKcwsZY/jpbV/IbDLU=
X-Received: by 2002:a2e:9881:: with SMTP id b1mr6584914ljj.134.1568226723574;
 Wed, 11 Sep 2019 11:32:03 -0700 (PDT)
MIME-Version: 1.0
From:   Gabriel C <nix.or.die@gmail.com>
Date:   Wed, 11 Sep 2019 20:31:37 +0200
Message-ID: <CAEJqkghRENck2NNCoxFccdph6EwAhMsBAszjkx2cj6Krrkoi8g@mail.gmail.com>
Subject: [Regression] 5.3-rc8 suspending from X broken with amdgpu
To:     LKML <linux-kernel@vger.kernel.org>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I am testing latest rc8/Linus git tree on my new
Acer Nitro 5 (AN515-43-R8BF) Laptop.

The box has an Ryzen7 3750H APU+RX 560x hybrid GPU(s).

Suspending ( closing the Lid ) from tty without X up
is working fine, however with X running doing the same
does not work. The display remains black.

It seems to be triggered from

 .. dcn10_hw_sequencer.c:932
dcn10_verify_allow_pstate_change_high.cold+0xc/0x229 [amdgpu]

The dmesg is way to big to post there so I uploaded it:

dmesg:
 http://crazy.dev.frugalware.org/Nitro5/dmesg.one.txt
lspci:
 http://crazy.dev.frugalware.org/Nitro5/lspci.nnvv.txt
 http://crazy.dev.frugalware.org/Nitro5/lspci.txt
config:
 http://crazy.dev.frugalware.org/Nitro5/config.nitro5-5.3-r8git

I didn't tested any other rcX kernels so I cannot tell if all are affected,
but 5.2.x kernels are working fine on this box.


The dirty state of the build is because this patch, which fixes the
NVME device on that box:
 https://lkml.org/lkml/2019/9/11/569

If you need more infos please let me know.
Also I can test any kind patches.

Best Regards,

Gabriel C
