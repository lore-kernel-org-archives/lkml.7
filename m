Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB3B2C7618B
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 14:33:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DB8F218EA
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 14:33:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="UiUhSzPc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732517AbfGWOdd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 10:33:33 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:52042 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728318AbfGWOdc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 10:33:32 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190723143330euoutp0264be6f13c0bae5072bf7d83d7de9bfda~0D9xzaOEO1069310693euoutp02Q
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2019 14:33:30 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190723143330euoutp0264be6f13c0bae5072bf7d83d7de9bfda~0D9xzaOEO1069310693euoutp02Q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1563892410;
        bh=3dI4WSCN1Syoio6H4JGJkxvn3KNeiKfNxDeEQLSlaYU=;
        h=From:Subject:To:Cc:Date:References:From;
        b=UiUhSzPc5CZRddVea4ybmGKb4JwVOOvz0Mt83DAxjdekSa7lxt1nJDsmiqIKVqUIB
         a5OuIK63D8rvPOHEs8X7EvI9gCf+HExIzliDCO5jz2VKCHDdoDMxXnX9TP966IsNgk
         TcxTBhqH7Chy5Y3kvulrLKyNQHMyrVAdb0aJIddU=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190723143329eucas1p117643dc9e4f58b19fc3fd45658457b65~0D9xcUAJL2227822278eucas1p1d;
        Tue, 23 Jul 2019 14:33:29 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 8F.18.04325.9BA173D5; Tue, 23
        Jul 2019 15:33:29 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190723143329eucas1p211688de2902dbac72998fda9e694083d~0D9wxcVoa0227002270eucas1p2P;
        Tue, 23 Jul 2019 14:33:29 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190723143328eusmtrp1d686ad3f98ed2c4ffbc8cd8ff46ef3cd~0D9wm7S621424814248eusmtrp1z;
        Tue, 23 Jul 2019 14:33:28 +0000 (GMT)
X-AuditID: cbfec7f5-b75ff700000010e5-f4-5d371ab91671
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id C2.4B.04140.8BA173D5; Tue, 23
        Jul 2019 15:33:28 +0100 (BST)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190723143328eusmtip2bca043c67d7707bbc87be382fc4714f6~0D9wYHACG0251202512eusmtip2B;
        Tue, 23 Jul 2019 14:33:28 +0000 (GMT)
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH] MAINTAINERS: handle fbdev changes through drm-misc tree
To:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>
Message-ID: <d449f697-ed25-8a3f-16d5-b981f1a52217@samsung.com>
Date:   Tue, 23 Jul 2019 16:33:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.6.1
MIME-Version: 1.0
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Sa0hTYRj227nsOJwcj4YvK7oMChK8lKGjbGT0Y/0r0Ahj5NSDim7ajvNS
        EKMfTVaEusochgrm3LxmNm+oOdFZgiUaRJAXMlHT0ua84KWcR8l/z/t8z/N+z/PxURhTQEio
        VE0Wq9Wo0qWkCLf3r38MbpNEKsNqlySyislvmGzU/ZuUDTxZJGQj7aXkJVzRuVKOK8YfOQUK
        V9PRa1icKCqJTU/NZrWh8nhRyrv5eizTKsydbPog0KMa0oi8KaDPgd1mEBqRiGLoagRDHba9
        YRlB67QBeVQM7UIwtpW471j/7CZ4kQVB8/YG4ocFBD0uF+5RkfR5KDTYdt3+tAL6ZheFHhxA
        x0N18YtdHqODYG1iZjeHmJZD3c+BHZ6icPok9M1Ee+hD9E0Y728keIkfvC+ZwnlrIHydKhPw
        +Bi0LJRingxAr5Lw/UcX6dkD9BXYfCDlQ/vDnLNZyOMjMGh6jPP6egRb+TN75hYEFtP23sNc
        gF7nMOFZhNGnoaE9lKejwb24RvD7feHLgh+fwReK7MUYT4sh/yHDq09BY1UjuX+tsc2K8VgB
        RssYWYBOmA80Mx9oZj7QzPw/QznCbSiQ1XHqZJYL17A5IZxKzek0ySGJGeomtPNPBred7lbU
        tZngQDSFpD7iXEGkkiFU2Vye2oGAwqQB4uv6CCUjTlLl3WW1Gbe1unSWc6DDFC4NFN/zmrjF
        0MmqLDaNZTNZ7f6pgPKW6JHV0JOHjE/dr33e6JiY8O7pv8o/DaGZNypedSrQ8rPL5YxluBWT
        bywl5hTVREW12+djRQUjb+ueX53YCpfH39ms1MekCI/fD0G93aaVUZjrEwgjimdLNB2/gi/S
        3FCOQ3L2ZVbluFcVfKpNWy3srdKHrZvKrHFkLBWZUEJIcS5FdSYI03Kqf8WIJhsjAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupikeLIzCtJLcpLzFFi42I5/e/4Pd0dUuaxBg9uGVgsfHiX2eLK1/ds
        Fif6PrBaXN41h82BxWPvtwUsHve7jzN5fN4kF8AcpWdTlF9akqqQkV9cYqsUbWhhpGdoaaFn
        ZGKpZ2hsHmtlZKqkb2eTkpqTWZZapG+XoJdx4M065oKV7BUPN51iamBczdbFyMkhIWAi8fPq
        V9YuRi4OIYGljBJPT95l6WLkAErISBxfXwZRIyzx51oXG0TNa0aJ/RtmM4Mk2ASsJCa2r2IE
        sYUFPCSOvvzADmKLCCRIPH09H2wBs4CWxI8HL8BsXgE7ibWvTzCCzGcRUJU4+sIRJCwqECFx
        5v0KFogSQYmTM5+wQLSqS/yZd4kZwhaXuPVkPhOELS+x/e0c5gmMArOQtMxC0jILScssJC0L
        GFlWMYqklhbnpucWG+kVJ+YWl+al6yXn525iBMbDtmM/t+xg7HoXfIhRgINRiYe3gsk8Vog1
        say4MvcQowQHs5IIb2CDWawQb0piZVVqUX58UWlOavEhRlOgfyYyS4km5wNjNa8k3tDU0NzC
        0tDc2NzYzEJJnLdD4GCMkEB6YklqdmpqQWoRTB8TB6dUA+OuFfGf769+2HZRo0G5p23x3qTf
        N02DVDVOGy9Pv7lZ/KLsEQn3cNeX26YVv9nhpvtLpOrplodZwrmhU78ybi58d2yJ8WLTF/9n
        aTovdra/HPy1w4eZRftI6o/Wd3su+qa/s5tQyz3JpXVX5Yo112Kvnuis/PZBVNfx2w5Xu+mx
        D4z2LGhaHKCkxFKckWioxVxUnAgAtVDmyZ0CAAA=
X-CMS-MailID: 20190723143329eucas1p211688de2902dbac72998fda9e694083d
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190723143329eucas1p211688de2902dbac72998fda9e694083d
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190723143329eucas1p211688de2902dbac72998fda9e694083d
References: <CGME20190723143329eucas1p211688de2902dbac72998fda9e694083d@eucas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fbdev patches will now go to upstream through drm-misc tree (IOW
starting with v5.4 merge window fbdev changes will be included in
DRM pull request) for improved maintainership and better integration
testing. Update MAINTAINERS file accordingly.

Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 MAINTAINERS |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: b/MAINTAINERS
===================================================================
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6389,7 +6389,7 @@ FRAMEBUFFER LAYER
 M:	Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
 L:	dri-devel@lists.freedesktop.org
 L:	linux-fbdev@vger.kernel.org
-T:	git git://github.com/bzolnier/linux.git
+T:	git git://anongit.freedesktop.org/drm/drm-misc
 Q:	http://patchwork.kernel.org/project/linux-fbdev/list/
 S:	Maintained
 F:	Documentation/fb/
