Return-Path: <SRS0=y5Xy=UI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1DC7C28EBD
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 05:46:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5538208C0
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 05:46:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pVKqLpUc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726552AbfFIFhs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Jun 2019 01:37:48 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:44742 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725802AbfFIFhs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jun 2019 01:37:48 -0400
Received: by mail-pl1-f194.google.com with SMTP id c5so2350141pll.11
        for <linux-kernel@vger.kernel.org>; Sat, 08 Jun 2019 22:37:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=+QmFFtwzYvOqX8rE4J9oMMueMclohVG5ztZbavEVIvY=;
        b=pVKqLpUcBQbuFjOPoFDW9DvZwqlmCeicF4D8kRjzDI8sz1x1dS/1gxsVHEXV1aaOec
         LQ48OtzS3wtFn0SlrBqixahVqCcplI1Xk1g30rr9eLUQFHqTGFDJO3a0aZyK+9G8BZb5
         1XIZKUwGVZ6TtdFURmSSBRi99LQqvOWA51viAV7XcsSFjRtdP/jUPkU5nSL03nhMlrJt
         HPBGcfCoQ58m4wR6DnGmqert7JM9CmOeXo0GnCvIzeoi4f+0SzLSNdNFgdCt88AJHa3R
         j1bQOxKvbzmRCk6gr0lllbVlRxH+88MDA0De3sh8fnYH7+AzdiSmbCkcbOeSBKtEQh74
         ppvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=+QmFFtwzYvOqX8rE4J9oMMueMclohVG5ztZbavEVIvY=;
        b=ooFMM7T1BjhKRu6+vg49MSlitmSdBpE+happk2LHbA76toHnVGnwVO4aUDjxAOZ/kd
         qMSakeVsM1YB8f3+xy0qynTDDy7B/07N0WUuLPb70lpnDCpjRRdRl97tKTplmhabtHiY
         aSePZCdaJVebwyeD//X3MP13e7fw7m9J77NQsjpohTyQUabJRFvQ825H3aLuuuVarIhJ
         l1DXontCx0LhdtMBSSwlNhZ8eYRbPOYZfAr2Rl9d8W+Sgm8phjGG2tP0vqtH4XVNwe4q
         DG1ntCDreZ2WCK8BO8tdnJx06XtU1axigb5CBtKZpupRFOExEJVG4p7leC85VD/khIfF
         7QSA==
X-Gm-Message-State: APjAAAXoN8iJtuBQIJZE/cnbkUKHowByoM2HQfQgMrVPLhYlqTHb2wLt
        xjb/6dyCNXNwXKmN7GBS8baxCqz4
X-Google-Smtp-Source: APXvYqwS/QT7pzWb9tSjsBsHlHkN21ha7wCJ7VS5WQdqtuh22Kpwk4OsR11ZHr9Mt1DXkoFczwHfKw==
X-Received: by 2002:a17:902:4481:: with SMTP id l1mr65412216pld.121.1560058666983;
        Sat, 08 Jun 2019 22:37:46 -0700 (PDT)
Received: from hari-Inspiron-1545 ([183.83.89.153])
        by smtp.gmail.com with ESMTPSA id k16sm6486953pfa.87.2019.06.08.22.37.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 08 Jun 2019 22:37:46 -0700 (PDT)
Date:   Sun, 9 Jun 2019 11:07:41 +0530
From:   Hariprasad Kelam <hariprasad.kelam@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Straube <straube.linux@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Hans de Goede <hdegoede@redhat.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: rtl8723bs: fix indentation issues
Message-ID: <20190609053741.GA12637@hari-Inspiron-1545>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fix below issues reported by checkpatch

CHECK: Please don't use multiple blank lines
WARNING: space prohibited between function name and open parenthesis '('
+void _rtw_open_pktfile (_pkt *pktptr, struct pkt_file *pfile)
WARNING: space prohibited before semicolon
WARNING: space prohibited between function name and open parenthesis '('
CHECK: spaces preferred around that '-' (ctx:VxV)
CHECK: Comparison to NULL could be written "!pxmitbuf->pallocated_buf"
CHECK: spaces preferred around that '*' (ctx:VxV)
CHECK: spaces preferred around that '/' (ctx:VxV)
WARNING: Missing a blank line after declarations
WARNING: braces {} are not necessary for single statement blocks
CHECK: spaces preferred around that '/' (ctx:VxV)
CHECK: Using comparison to true is error prone

Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>
---
 drivers/staging/rtl8723bs/os_dep/xmit_linux.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/drivers/staging/rtl8723bs/os_dep/xmit_linux.c b/drivers/staging/rtl8723bs/os_dep/xmit_linux.c
index 4e4e565..39abfaf 100644
--- a/drivers/staging/rtl8723bs/os_dep/xmit_linux.c
+++ b/drivers/staging/rtl8723bs/os_dep/xmit_linux.c
@@ -9,22 +9,21 @@
 #include <drv_types.h>
 #include <rtw_debug.h>
 
-
 uint rtw_remainder_len(struct pkt_file *pfile)
 {
 	return (pfile->buf_len - ((SIZE_PTR)(pfile->cur_addr) - (SIZE_PTR)(pfile->buf_start)));
 }
 
-void _rtw_open_pktfile (_pkt *pktptr, struct pkt_file *pfile)
+void _rtw_open_pktfile(_pkt *pktptr, struct pkt_file *pfile)
 {
 	pfile->pkt = pktptr;
 	pfile->cur_addr = pfile->buf_start = pktptr->data;
 	pfile->pkt_len = pfile->buf_len = pktptr->len;
 
-	pfile->cur_buffer = pfile->buf_start ;
+	pfile->cur_buffer = pfile->buf_start;
 }
 
-uint _rtw_pktfile_read (struct pkt_file *pfile, u8 *rmem, uint rlen)
+uint _rtw_pktfile_read(struct pkt_file *pfile, u8 *rmem, uint rlen)
 {
 	uint	len = 0;
 
@@ -32,7 +31,7 @@ uint _rtw_pktfile_read (struct pkt_file *pfile, u8 *rmem, uint rlen)
 	len = (rlen > len) ? len : rlen;
 
 	if (rmem)
-		skb_copy_bits(pfile->pkt, pfile->buf_len-pfile->pkt_len, rmem, len);
+		skb_copy_bits(pfile->pkt, pfile->buf_len - pfile->pkt_len, rmem, len);
 
 	pfile->cur_addr += len;
 	pfile->pkt_len -= len;
@@ -50,7 +49,7 @@ int rtw_os_xmit_resource_alloc(struct adapter *padapter, struct xmit_buf *pxmitb
 {
 	if (alloc_sz > 0) {
 		pxmitbuf->pallocated_buf = rtw_zmalloc(alloc_sz);
-		if (pxmitbuf->pallocated_buf == NULL)
+		if (!pxmitbuf->pallocated_buf)
 			return _FAIL;
 
 		pxmitbuf->pbuf = (u8 *)N_BYTE_ALIGMENT((SIZE_PTR)(pxmitbuf->pallocated_buf), XMITBUF_ALIGN_SZ);
@@ -65,7 +64,7 @@ void rtw_os_xmit_resource_free(struct adapter *padapter, struct xmit_buf *pxmitb
 		kfree(pxmitbuf->pallocated_buf);
 }
 
-#define WMM_XMIT_THRESHOLD	(NR_XMITFRAME*2/5)
+#define WMM_XMIT_THRESHOLD	(NR_XMITFRAME * 2 / 5)
 
 void rtw_os_pkt_complete(struct adapter *padapter, _pkt *pkt)
 {
@@ -148,13 +147,13 @@ static int rtw_mlcst2unicst(struct adapter *padapter, struct sk_buff *skb)
 	/* free sta asoc_queue */
 	while (phead != plist) {
 		int stainfo_offset;
+
 		psta = LIST_CONTAINOR(plist, struct sta_info, asoc_list);
 		plist = get_next(plist);
 
 		stainfo_offset = rtw_stainfo_offset(pstapriv, psta);
-		if (stainfo_offset_valid(stainfo_offset)) {
+		if (stainfo_offset_valid(stainfo_offset))
 			chk_alive_list[chk_alive_num++] = stainfo_offset;
-		}
 	}
 	spin_unlock_bh(&pstapriv->asoc_list_lock);
 
@@ -229,9 +228,9 @@ int _rtw_xmit_entry(_pkt *pkt, _nic_hdl pnetdev)
 			#endif
 			)
 		&& padapter->registrypriv.wifi_spec == 0) {
-		if (pxmitpriv->free_xmitframe_cnt > (NR_XMITFRAME/4)) {
+		if (pxmitpriv->free_xmitframe_cnt > (NR_XMITFRAME / 4)) {
 			res = rtw_mlcst2unicst(padapter, pkt);
-			if (res == true)
+			if (res)
 				goto exit;
 		} else {
 			/* DBG_871X("Stop M2U(%d, %d)! ", pxmitpriv->free_xmitframe_cnt, pxmitpriv->free_xmitbuf_cnt); */
-- 
2.7.4

