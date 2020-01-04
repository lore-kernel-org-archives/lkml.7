Return-Path: <SRS0=lTpO=2Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBF52C32771
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jan 2020 21:48:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7BD822B48
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jan 2020 21:48:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726368AbgADVsl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Jan 2020 16:48:41 -0500
Received: from mout.kundenserver.de ([217.72.192.75]:49351 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726170AbgADVsl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jan 2020 16:48:41 -0500
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.145]) with ESMTPA (Nemesis) id
 1MPXpU-1j1hCa2l2g-00MYuj; Sat, 04 Jan 2020 22:48:34 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Hariprasad Kelam <hariprasad.kelam@gmail.com>,
        =?UTF-8?q?Florian=20B=C3=BCstgens?= <flbue@gmx.de>,
        Michael Straube <straube.linux@gmail.com>,
        Nishka Dasgupta <nishkadg.linux@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: rtl8188: avoid excessive stack usage
Date:   Sat,  4 Jan 2020 22:48:21 +0100
Message-Id: <20200104214832.558198-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:Dujd3H1Dqz4viqnqZotC9wqLY9PFh4J/b95mmgxVkfB3sMcRYTL
 q7izsObtY7055Yvf8dsNNxiJvn4uFL3Nrmmwx1ye1anAQz2x7/44bJ1Mc+eiUglE4er1IcD
 puwJ/YIzolREIlvsjnbpOMPEXm/z9xOMDFCcTvHnecqA90BE8/zMS7tYEMRZmUSUOps6SsM
 AqqmhyWG6biV9FJ9FSB4w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:f6UG+xlVb74=:6WIIsMIZJZcovNJxIjmvdH
 GDNJPFdaiV/8o1ynD1uSgDS7EIGf7YiOVLDqPFwxZuGYx7KQMkhssCEsN+aA0hL38485pvOXS
 gT4qUcSvQRjZaNMa0pjyC/iEz1AYCU9ZtwVnJ7ly3pPrLVDofQu1xP7rFiFtv8bm3jN/fRbtq
 dsKbWpfY0m6SaoivALVS7fBW/X4fa4ozX1Vqgagks+NwuQ5pNhLTO5J12W2A+4KSGs+tel3M2
 H4qMDJmWXWiw196IDkKw2XUJ5UCLOShbgOlF4KRf2N7DtybEjuv9o4a95AFLvTpY+Hb8/tam0
 uV+UIRqRRMf3rjFKIAWMZ+mYwxTXRby2DoOqUwpVZw5XXymde0Jl1BTPoYMPe93Bj2HiLA+Of
 bDlONlxwlIA1Isc95McdyhDi+U2beU6KIz/tqKngY2yO1Oa9qXaTWZTEGZ8bSwLoAAcN0+IZV
 gyJ4JuvHwzI1otxK5jBAcGfSHBLRl7XOQ1hAdCmqmr0N/2IWGXlWH0nOxTIdWLevwsAINYJgz
 rw8XXEbtdk/n/DHQSqwdyLrYauUprYx8/CwlOT7uOPmrerI74FyPgF7oPTWFwCo1YLp/ZclSp
 EFaAVdr7k46gP8elnogMvpUIZOKH50AkTajPODZooFbnWVbCaZctURLJMDdJ/o1tu980GOgux
 y7ejIHz+PzAeLOO2V63LIyaK8wR/kOFry7BHWJKWkLKwE7G0AQSlChyRz+Q27rffZyW5xcSIf
 UORRJQ5NT41SH0dKzt/eSU/VC2ghwxmF+mjbD+Xe+YrgSMc53PVIo8H5f9wX1d++xpm+iP+LL
 MJMNgpbLF7mUDit8saxvGE7StJvtwlVW0izvudxnEvrTYBoD4MrifLJDzZc7b6qYD7UCamJ0i
 bpRcKi7zN7AMuL3ecURA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The rtl8188 copy of the os_dep support code causes a
warning about a very significant stack usage in the translate_scan()
function:

drivers/staging/rtl8188eu/os_dep/ioctl_linux.c: In function 'translate_scan':
drivers/staging/rtl8188eu/os_dep/ioctl_linux.c:306:1: error: the frame size of 1560 bytes is larger than 1400 bytes [-Werror=frame-larger-than=]

Use the same trick as in the rtl8723bs copy of the same function, and
allocate it dynamically.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/staging/rtl8188eu/os_dep/ioctl_linux.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8188eu/os_dep/ioctl_linux.c b/drivers/staging/rtl8188eu/os_dep/ioctl_linux.c
index 710c33fd4965..47f4cc6a19a9 100644
--- a/drivers/staging/rtl8188eu/os_dep/ioctl_linux.c
+++ b/drivers/staging/rtl8188eu/os_dep/ioctl_linux.c
@@ -222,18 +222,21 @@ static char *translate_scan(struct adapter *padapter,
 
 	/* parsing WPA/WPA2 IE */
 	{
-		u8 buf[MAX_WPA_IE_LEN];
+		u8 *buf;
 		u8 wpa_ie[255], rsn_ie[255];
 		u16 wpa_len = 0, rsn_len = 0;
 		u8 *p;
 
+		buf = kzalloc(MAX_WPA_IE_LEN, GFP_ATOMIC);
+		if (!buf)
+			return start;
+
 		rtw_get_sec_ie(pnetwork->network.ies, pnetwork->network.ie_length, rsn_ie, &rsn_len, wpa_ie, &wpa_len);
 		RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_, ("rtw_wx_get_scan: ssid =%s\n", pnetwork->network.ssid.ssid));
 		RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_, ("rtw_wx_get_scan: wpa_len =%d rsn_len =%d\n", wpa_len, rsn_len));
 
 		if (wpa_len > 0) {
 			p = buf;
-			memset(buf, 0, MAX_WPA_IE_LEN);
 			p += sprintf(p, "wpa_ie=");
 			for (i = 0; i < wpa_len; i++)
 				p += sprintf(p, "%02x", wpa_ie[i]);
@@ -250,7 +253,6 @@ static char *translate_scan(struct adapter *padapter,
 		}
 		if (rsn_len > 0) {
 			p = buf;
-			memset(buf, 0, MAX_WPA_IE_LEN);
 			p += sprintf(p, "rsn_ie=");
 			for (i = 0; i < rsn_len; i++)
 				p += sprintf(p, "%02x", rsn_ie[i]);
@@ -264,6 +266,7 @@ static char *translate_scan(struct adapter *padapter,
 			iwe.u.data.length = rsn_len;
 			start = iwe_stream_add_point(info, start, stop, &iwe, rsn_ie);
 		}
+		kfree(buf);
 	}
 
 	{/* parsing WPS IE */
-- 
2.20.0

