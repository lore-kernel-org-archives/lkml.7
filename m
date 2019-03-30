Return-Path: <SRS0=yJb2=SB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00EA2C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 18:18:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA73F217F5
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 18:18:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OlT9KYmj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730989AbfC3SSa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Mar 2019 14:18:30 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:45078 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730675AbfC3SSa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Mar 2019 14:18:30 -0400
Received: by mail-pf1-f194.google.com with SMTP id e24so2532874pfi.12
        for <linux-kernel@vger.kernel.org>; Sat, 30 Mar 2019 11:18:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=Y/zMe7CEV/WW0bORdE4cFBP7bCFLOnoAlCzMTpzmu+8=;
        b=OlT9KYmjnG3E2pswSco7230OvmXylxsUvvp7lBV34sLw7KJTO+39G5nI/WNOiOvKbI
         mg/7JvwPiJ5C3Uox/ZYZbOif6dA/66OHZ4YgAhYRvPEVF6w7N3ZqwGEmgkYHjGOBSryv
         fituCBuwU1pwqmg3NfpqjXzHFnVtTbT9kXyu494qxyihVB9DNvW4Wlg1lNd2ybDecgY8
         vyUR8kD4N92LWFcrtaScu7IroRrKXNzDlFBjYlsrQGTUA/g+Qn+NjfAqwm/X2bMG5ECO
         Imee6AgeIxmievajR9tYgRpmRck7NOx4Klqy7lEePKKqy55AQnx/UfJJMylstBIAW/uT
         WTdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=Y/zMe7CEV/WW0bORdE4cFBP7bCFLOnoAlCzMTpzmu+8=;
        b=ENH0nCOsPvKtL6HHA3Cf5ci0bSf0Hy5Qk6qp+RSc07lbsPY3ff8ucvPHENFEUFPoLG
         OuaeVo2QD6rFemOdlvUTjJoJ1hf1lRfWqW56o7Ii5JynqeAEYXWokBR7NmrixVJrholW
         DeiqkEEqRl7LFFN3KINCYfBaunD3CvFdj4904Hbvuhku3zhhbHD6zRrigpfmB1mxs8e4
         dvhxUpA+qEZBL7VCHfuKRHGW6gebL5pUPruTyI5gu9uFz8U80Eh8JCvHtqKYfHrENETG
         P2YB2VK7jjSzn6wft/c/520CZEILgOGMgO6LTNea/fSwDQoq07TdW4Zz+p81KlRjdQku
         dOOA==
X-Gm-Message-State: APjAAAWOA3LpmWQ9qREBUAzZpCdl4+IUZmvIQgluX/w/wJVYoaSP5t69
        WkwJIhTF1bR0q65cPqE+yCs=
X-Google-Smtp-Source: APXvYqzQW+rmkuC5HxwsFWGhj4fRQRImZwwnz1Tc26TgDT8s9cNKYipwH417zEpBEQRxDkX9UbLxVA==
X-Received: by 2002:aa7:82cb:: with SMTP id f11mr47889969pfn.0.1553969909355;
        Sat, 30 Mar 2019 11:18:29 -0700 (PDT)
Received: from hari-Inspiron-1545 ([183.83.91.90])
        by smtp.gmail.com with ESMTPSA id o68sm17953722pfi.140.2019.03.30.11.18.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 30 Mar 2019 11:18:28 -0700 (PDT)
Date:   Sat, 30 Mar 2019 23:48:23 +0530
From:   Hariprasad Kelam <hariprasad.kelam@gmail.com>
To:     luc.vanoostenryck@gmail.com, rostedt@goodmis.org, mingo@redhat.com,
        roopa@cumulusnetworks.com, davem@davemloft.net,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] trace: events: fix error directive in argument list
Message-ID: <20190330181823.GA16263@hari-Inspiron-1545>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes below spare errors.

Sparse error:
make C=2 CF=-D__CHECK_ENDIAN__ M=net/core
./include/trace/events/neigh.h:73:1: error: directive in argument list
./include/trace/events/neigh.h:78:1: error: directive in argument list
./include/trace/events/neigh.h:150:1: error: directive in argument list
./include/trace/events/neigh.h:155:1: error: directive in argument list

Changes below two lines to signle line to avoid sparse error
               if (n->tbl->family == AF_INET6) {
to if (IS_ENABLED(CONFIG_IPV6) && n->tbl->family == AF_INET6)

Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>
---
Changes in V2:
                -Divide patch to only address spare error
---
 include/trace/events/neigh.h | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/include/trace/events/neigh.h b/include/trace/events/neigh.h
index 0bdb085..2ca0180 100644
--- a/include/trace/events/neigh.h
+++ b/include/trace/events/neigh.h
@@ -70,12 +70,10 @@ TRACE_EVENT(neigh_update,
 		else
 			*p32 = 0;
 
-#if IS_ENABLED(CONFIG_IPV6)
-		if (n->tbl->family == AF_INET6) {
+		if (IS_ENABLED(CONFIG_IPV6) && n->tbl->family == AF_INET6) {
 			pin6 = (struct in6_addr *)__entry->primary_key6;
 			*pin6 = *(struct in6_addr *)n->primary_key;
 		} else
-#endif
 		{
 			ipv6_addr_set_v4mapped(*p32, pin6);
 		}
@@ -147,12 +145,10 @@ DECLARE_EVENT_CLASS(neigh__update,
 		else
 			*p32 = 0;
 
-#if IS_ENABLED(CONFIG_IPV6)
-		if (n->tbl->family == AF_INET6) {
+		if (IS_ENABLED(CONFIG_IPV6) && n->tbl->family == AF_INET6) {
 			pin6 = (struct in6_addr *)__entry->primary_key6;
 			*pin6 = *(struct in6_addr *)n->primary_key;
 		} else
-#endif
 		{
 			ipv6_addr_set_v4mapped(*p32, pin6);
 		}
-- 
2.7.4

