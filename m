Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E5A4C10F03
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 14:10:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46585218E2
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 14:10:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728673AbfCVOKI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 10:10:08 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:37309 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727487AbfCVOKH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 10:10:07 -0400
Received: from wuerfel.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.145]) with ESMTPA (Nemesis) id
 1MVdYY-1hWWi820tY-00RXj6; Fri, 22 Mar 2019 15:09:40 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     clang-built-linux@googlegroups.com,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] iio: ssp_sensors: avoid uninitialized variable usage
Date:   Fri, 22 Mar 2019 15:09:22 +0100
Message-Id: <20190322140937.341976-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:QnhDsqh0KFlM5KhzUi7mwUL/YxGqNJt2E7AsUWOjxw8veKn2kNV
 GVKj1SnggcVRNfOWjpqszRpv6aG7YhNIJKMdSSj/pb0uGa61sLQZGXHnJiDTIBj22tljuPx
 5Pilkt2DjVO2OJ99kLk44aQ5o5meReVb2ATUEL3otYpGfyTEpEYTqQ7M4MyUZHZwel6jaCF
 fsoq8/QyCbrPeWOFH1aWA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:NqvslkTHWSA=:5YLorGwbZnoLpmp35glNcR
 a0wm+HstR6VbmrvopVmYSxi31OJiUDThx841ncqQZ/vy5S//QjxLS41yaK0mEjYnXGSQj8gkQ
 xm/HCuwuoSEFYJYqFp3TILDvYSf5A0ZUPQeauRZGvkwACGitKj43maayK7pGG0yp0i0D+hKyF
 mYIg+tTdSp7uerR4bm7i1Lrh4SC4vI9z3Eo0/8j1j2ofc7P0Ok0Ccc9dpDk+8jUdh71antlFl
 0QSofRrau8A53+9pdS5MST+DBp2/UhG/9QRz0fWh8vkK+I1hGH8vespqeTiClIjgeEYsJBHan
 +Yu5/YehILkU213dipTv/wFgP7ju49sliEvcUTb29a7O4f35Q8Yy2o0fewyLKuqULL6Jedrnw
 fBC4HO6taoPnetwyv5UkGIEXp0Bd4DKPIAK0jwYZOGRb4E3MBwFe+g6bShd7u5aED5K/h7TiE
 flGE/5bkcaHQWfnFGhb4YWvPfAFi3o98fM9264lf/VgT2EW26jOIvtI0gj5HYEKZ5kD9OxK/A
 Za8rwM4gs0s1detjYq1CRFZ5xMAN0OcwOxC6Hs5TUO4VtAQ+75dzpmsy7N9lHKyIpmDmPc2bH
 QkEg/ZgkkEWOnF5RwoCELVMNzbeE8u1TP5LnjtldbPXu1Y4vTfO32oT2BjMxPQXBsyIy5h24a
 4se/ewvyC4XzhJc9Z6vtCRd6XDs3HIQmGR7etjVCOrYATMlUyNNio2h+HzNEzH58K9ixLUNda
 1h5h3ox2cXMkg/eu/Ejo6E1ntXXyaNqut8Kebw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

clang points out that 'calculated_time' is only sometimes
initialized here, which leads to incorrect data being
passed into another function:

drivers/iio/common/ssp_sensors/ssp_iio.c:95:6: error: variable 'calculated_time' is used uninitialized whenever 'if' condition is false [-Werror,-Wsometimes-uninitialized]
        if (indio_dev->scan_timestamp) {
            ^~~~~~~~~~~~~~~~~~~~~~~~~
drivers/iio/common/ssp_sensors/ssp_iio.c:102:9: note: uninitialized use occurs here
                                                  calculated_time);
                                                  ^~~~~~~~~~~~~~~
drivers/iio/common/ssp_sensors/ssp_iio.c:95:2: note: remove the 'if' if its condition is always true
        if (indio_dev->scan_timestamp) {
        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/iio/common/ssp_sensors/ssp_iio.c:84:25: note: initialize the variable 'calculated_time' to silence this warning
        int64_t calculated_time;
                               ^
The data is subsequently ignored by iio_push_to_buffers_with_timestamp(),
but the warning still feels legitimate and to work around it, we can
initialize the time in the other case.

Link: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=18501
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/iio/common/ssp_sensors/ssp_iio.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iio/common/ssp_sensors/ssp_iio.c b/drivers/iio/common/ssp_sensors/ssp_iio.c
index 645f2e3975db..81e8f4844c90 100644
--- a/drivers/iio/common/ssp_sensors/ssp_iio.c
+++ b/drivers/iio/common/ssp_sensors/ssp_iio.c
@@ -96,6 +96,8 @@ int ssp_common_process_data(struct iio_dev *indio_dev, void *buf,
 		memcpy(&time, &((char *)buf)[len], SSP_TIME_SIZE);
 		calculated_time =
 			timestamp + (int64_t)le32_to_cpu(time) * 1000000;
+	} else {
+		calculated_time = 0;
 	}
 
 	return iio_push_to_buffers_with_timestamp(indio_dev, spd->buffer,
-- 
2.20.0

