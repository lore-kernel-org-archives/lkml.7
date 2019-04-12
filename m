Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C80EEC10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 09:42:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6483C20850
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 09:42:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="hgOEGvd9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726753AbfDLJmV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 05:42:21 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:49936 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726694AbfDLJmV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 05:42:21 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190412094219euoutp015d6aa2421dfe7ba820d40b0dc2a17600~UsMbj9R3s2683626836euoutp01d
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2019 09:42:19 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190412094219euoutp015d6aa2421dfe7ba820d40b0dc2a17600~UsMbj9R3s2683626836euoutp01d
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1555062139;
        bh=R0BwEH5WYPQugEA98YZxuVM1krJCBXYcYofL19hK61s=;
        h=To:Cc:From:Subject:Date:References:From;
        b=hgOEGvd9RkamxS4hsVF10k+9LnItmnkwmXXIYzh1DMIfjAYM/VFSQAgA6mpmnrm8F
         gGD1BaHggWjgX68monTRep6DrAnlBDFoLTZ7oHfBpui388wOeC0YD111zz4xA19kYz
         5EZqgvyVe9HNBHkL2FFd12vRB7rULBi5ox/7Hl4s=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190412094219eucas1p1623f6f7e740c1dfd58ef783f72ee137e~UsMbHY_o20458704587eucas1p1U;
        Fri, 12 Apr 2019 09:42:19 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 67.78.04377.A7D50BC5; Fri, 12
        Apr 2019 10:42:18 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190412094218eucas1p1193664ba9717366a175c1b39038afcf5~UsMaWGVo60458004580eucas1p1-;
        Fri, 12 Apr 2019 09:42:18 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190412094218eusmtrp2fe8f4c256c6f18abc154009e8f5174eb~UsMaIJg_40581805818eusmtrp2O;
        Fri, 12 Apr 2019 09:42:18 +0000 (GMT)
X-AuditID: cbfec7f4-12dff70000001119-2f-5cb05d7acba2
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 85.D0.04146.97D50BC5; Fri, 12
        Apr 2019 10:42:18 +0100 (BST)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190412094217eusmtip178f6e500a2b1d886efc6608c99eaf760~UsMZ3R6Lv0356703567eusmtip1p;
        Fri, 12 Apr 2019 09:42:17 +0000 (GMT)
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH] arm64: remove redundant 'default n' from Kconfig
Message-ID: <b0efd68a-8120-188f-cdee-8b346087b6d9@samsung.com>
Date:   Fri, 12 Apr 2019 11:42:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
        Thunderbird/45.3.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpkleLIzCtJLcpLzFFi42LZduznOd2q2A0xBrvWG1i8X9bDaLHp8TVW
        i8u75rBZvPx4gsWBxWPNvDWMHpuX1Ht83iQXwBzFZZOSmpNZllqkb5fAlTFvRQNTwWbuikm3
        sxoYz3N0MXJwSAiYSPxYrtDFyMUhJLCCUeLd48fMEM4XRomj736yQTifGSWebetg72LkBOto
        3PuLBSKxnFHiyfRmVpCEkMBbRombT+1AbBGBIIkNTx+wgNjMAm4Sfzu7wWrYBKwkJravYgSx
        hQUcJR4+6WUCsXkF7CQ6J5wBW8AioCqx6PwSZpDzRAUiJPrPqEOUCEqcnPkEaqS8xPa3c8Au
        lRB4zCZx4O8EZojjXCQe/N8IZQtLvDq+BepoGYn/O+czQTSsY5T42/ECqns7o8Tyyf/YIKqs
        JQ4fv8gKsplZQFNi/S59iLCjxLO921kh4cUnceOtIMQRfBKTtk1nhgjzSnS0CUFUq0lsWLaB
        DWZt186VUCUeEke+ZENCKlbiwIYFTBMYFWYh+WwWks9mIZywgJF5FaN4amlxbnpqsVFearle
        cWJucWleul5yfu4mRmDCOP3v+JcdjLv+JB1iFOBgVOLhjXBcHyPEmlhWXJl7iFGCg1lJhDeE
        BSjEm5JYWZValB9fVJqTWnyIUZqDRUmct5rhQbSQQHpiSWp2ampBahFMlomDU6qBUdOvcc+a
        nm0blCOrrFxk3tdPDP55rd9NSmXN92Mxnx+wde+wELsZczElc5Np2JXNS3/c1pkeG7r45PN/
        aoUHuPQdz52uUzYR2H4p8lj8xqB/Nztvts9Qavqf/Hb+5o7vuzyMub+cea658pbp6zltaScY
        fjSJhHmuul++/tya+4w77sVzv7r2xF6JpTgj0VCLuag4EQD6P/ZoFAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrALMWRmVeSWpSXmKPExsVy+t/xu7pVsRtiDP7WWrxf1sNosenxNVaL
        y7vmsFm8/HiCxYHFY828NYwem5fUe3zeJBfAHKVnU5RfWpKqkJFfXGKrFG1oYaRnaGmhZ2Ri
        qWdobB5rZWSqpG9nk5Kak1mWWqRvl6CXMW9FA1PBZu6KSbezGhjPc3QxcnJICJhINO79xdLF
        yMUhJLCUUeJK5zTWLkYOoISMxPH1ZRA1whJ/rnWxQdS8ZpToOHaEBSQhIhAkcXrGdSYQm1nA
        TeJvZzcriM0mYCUxsX0VI4gtLOAo8fBJL1gNr4CdROeEM+wgNouAqsSi80uYQWxRgQiJWw87
        WCBqBCVOznzCAjFTXeLPvEvMELa8xPa3c5gnMPLPQlI2C0nZLCRlCxiZVzGKpJYW56bnFhvq
        FSfmFpfmpesl5+duYgSG9rZjPzfvYLy0MfgQowAHoxIPb4DV+hgh1sSy4srcQ4wSHMxKIrwh
        LEAh3pTEyqrUovz4otKc1OJDjKZAh09klhJNzgfGXV5JvKGpobmFpaG5sbmxmYWSOO95g8oo
        IYH0xJLU7NTUgtQimD4mDk6pBkam3eWH62OWG/wsXFolzudmabRo2eoW+VTnjG9h5xe+T2fY
        rdSy7ox/afufnnSP058DPm3ad3O9uf7qnFUn9tz6fL9R84mEaW3o5Opp898Uv9TdxTyt5sOu
        U+Ex02bt1WT4ePL33ud7q3NLq3xTdbYbX3lzOUhmeQXz9vJqm2OM0w/wmfz/ccxYiaU4I9FQ
        i7moOBEAdsJMioMCAAA=
X-CMS-MailID: 20190412094218eucas1p1193664ba9717366a175c1b39038afcf5
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190412094218eucas1p1193664ba9717366a175c1b39038afcf5
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190412094218eucas1p1193664ba9717366a175c1b39038afcf5
References: <CGME20190412094218eucas1p1193664ba9717366a175c1b39038afcf5@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'default n' is the default value for any bool or tristate Kconfig
setting so there is no need to write it explicitly.

Also since commit f467c5640c29 ("kconfig: only write '# CONFIG_FOO
is not set' for visible symbols") the Kconfig behavior is the same
regardless of 'default n' being present or not:

    ...
    One side effect of (and the main motivation for) this change is making
    the following two definitions behave exactly the same:
    
        config FOO
                bool
    
        config FOO
                bool
                default n
    
    With this change, neither of these will generate a
    '# CONFIG_FOO is not set' line (assuming FOO isn't selected/implied).
    That might make it clearer to people that a bare 'default n' is
    redundant.
    ...

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 arch/arm64/Kconfig |    1 -
 1 file changed, 1 deletion(-)

Index: b/arch/arm64/Kconfig
===================================================================
--- a/arch/arm64/Kconfig	2019-04-12 11:40:06.118091734 +0200
+++ b/arch/arm64/Kconfig	2019-04-12 11:40:06.102091733 +0200
@@ -916,7 +916,6 @@ config PARAVIRT
 config PARAVIRT_TIME_ACCOUNTING
 	bool "Paravirtual steal time accounting"
 	select PARAVIRT
-	default n
 	help
 	  Select this option to enable fine granularity task steal time
 	  accounting. Time spent executing other tasks in parallel with
