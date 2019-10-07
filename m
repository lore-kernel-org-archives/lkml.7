Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D33D0C47404
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 20:34:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7CBF2084D
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 20:34:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ucr.edu header.i=@ucr.edu header.b="N6ZTtlbH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729264AbfJGUeQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 16:34:16 -0400
Received: from mx6.ucr.edu ([138.23.62.71]:30395 "EHLO mx6.ucr.edu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728289AbfJGUeQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 16:34:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=ucr.edu; i=@ucr.edu; q=dns/txt; s=selector3;
  t=1570480457; x=1602016457;
  h=mime-version:from:date:message-id:subject:to;
  bh=lP0s6TrPhUPnA9k0J9KDX5uHH6OZht5S6Chm9LUAoQI=;
  b=N6ZTtlbH/A0YpXb6pHSHIOjihlB06ghdLDrnafLmF4Gx0vHlpWMV8KaU
   ASBslb/wHH6JB8b1wzRBOXso+BcactShK2fm0JGW7N0aooahjXzGEe+sb
   WkS9P/ruNJ5/dGdottHrCkgh7tA6J3QQf/zzfwygGnyNzZK2M2cGy76i5
   p9PUF50QsS1y2pVMEkwyZN8QntceO02DB02bzbhKeEMI00zz2O5xpJaue
   TcAGt4UIVS1TF+L814M8BlDk5DOTHJ2KVrMDkIScj6AsuzwSyxIQmLJiy
   7iagcbz37Fp27WRGMWum2BT+dHo3K0YaUYYs9yU0ikbMcaWm/IgM7Hr4Y
   Q==;
IronPort-SDR: DH9UlW6Y15zoI2AKz+43uIkKYQrLp+XBWlA7DKd//9Z3czPgvu+esPixqVlms7ehq2DF+N8vg+
 FWkAhm6dYUSJenGf+49Agc7NSUJWoQQ3megs7TyRIr8t1GAH1XxnES65OSGudNjCqAnQAXLqdm
 DQtNuvHRSyvGAbeT1Ub7V7h3krMg6NIdlTa8Yg3fUwG4eKh/AFbfjsU1TcLCbA3PxctllKohwT
 qnBfAmsSnIa5byELXpuq8Ve1J9EMEEAvQP5qslWBEBqqw4f0OoDxYTcpN+2gHbH5GnthZ9kb49
 9/o=
IronPort-PHdr: =?us-ascii?q?9a23=3A1dmVKRTQ9GYDCqsyEonw5r9QXdpsv+yvbD5Q0Y?=
 =?us-ascii?q?Iujvd0So/mwa6zYheN2/xhgRfzUJnB7Loc0qyK6vumBDNLuM3R+Fk5M7V0Hy?=
 =?us-ascii?q?cfjssXmwFySOWkMmbcaMDQUiohAc5ZX0Vk9XzoeWJcGcL5ekGA6ibqtW1aFR?=
 =?us-ascii?q?rwLxd6KfroEYDOkcu3y/qy+5rOaAlUmTaxe7x/IAi4oAnLtsQbg4RuJrs/xx?=
 =?us-ascii?q?bKv3BFZ/lYyWR0KFyJgh3y/N2w/Jlt8yRRv/Iu6ctNWrjkcqo7ULJVEi0oP3?=
 =?us-ascii?q?g668P3uxbDSxCP5mYHXWUNjhVIGQnF4wrkUZr3ryD3q/By2CiePc3xULA0RT?=
 =?us-ascii?q?Gv5LplRRP0lCsKMSMy/XrJgcJskq1UvBOhpwR+w4HKZoGVKOF+db7Zcd8DWG?=
 =?us-ascii?q?ZNQtpdWylHD4ihbYUAEvABMP5XoIf9qVUArgawCxewC+701j9EmmX70bEm3+?=
 =?us-ascii?q?g9EwzL2hErEdIUsHTTqdX4LKUdUeG0zanI0DXDaO5d1jT96IfScxAqvPaBXL?=
 =?us-ascii?q?JxcMrR00YvFh/JgkmepIH+IjOayv4Nv3KF4OV9SOKikmgqoBxyrDi33soglJ?=
 =?us-ascii?q?XFi4YPxl3H9Sh12pg5KcG7RUJhfNKpFJ9duieHPIVsWMwiWXtnuCMix70Dvp?=
 =?us-ascii?q?60YTYFxYw8xx7ad/yHa4+I4g//VOqJITd3mnZleLWniha360egy+n8WtCw0F?=
 =?us-ascii?q?ZIsyZJi9fMum0J2hHX8MSHRfx9/kCu2TaLyQ/f8P1LIUcxlabDKp4hxKA/lo?=
 =?us-ascii?q?YLvEjdAiP7nF/6gayWe0k+5OSk9+fqbq/7qpKYM4J4kgT+Pb4vmsy7D+Q4KA?=
 =?us-ascii?q?8OX22D9OW81bzj/Vf2QLRWgvEqnKTUq43aKtgBpqKjHQBaz5sj5w6lDzi6yN?=
 =?us-ascii?q?QYgWUHLFVddRKDjojpPUzOIf/hAfe8nVusijFryO7CPrD6HJXNIWbMkK37cb?=
 =?us-ascii?q?Z+9UFc0gwzws5b555ODbEBOv3zCQfNs4mSLBY8Phf87qDFTp1X0Z8CXmeLD7?=
 =?us-ascii?q?7TePfQvF2CzuYuJfScIo4fvXD2LP1zo7akqHYjhV4bNYrvlaMadH2iBflgaQ?=
 =?us-ascii?q?3NZHP2ntYHV38HogckV+HsoFqYWDVXajC5WKdqonk/CYS7HcLYTZusqKKO0T?=
 =?us-ascii?q?39HZBMYG1CTFeWHjOgc4SCRudJay+IJMJluiILWKLnSII70xyq8gjgxP4vHO?=
 =?us-ascii?q?rV6zAe/avi3d49s//TlAAv8yVcBN/bzmqXCWx4gzVMDxQ20aZwsFE18VCF3u?=
 =?us-ascii?q?AsiOdfE9N77OgPTwwgc5PQ0ropJcr1X1fwf8WJVVHucNWvAHllX8Axyt5WOx?=
 =?us-ascii?q?1VBt64yB3Pwnz5UPcui7WXCclsoern1H/rKpM4ki6e2Q=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2EVAwBIoJtdh8fQVdFmDoYghE2OYYU?=
 =?us-ascii?q?XAYZ3hVmBGIo0AQgBAQEOLwEBhx8jOBMCAwkBAQUBAQEBAQUEAQECEAEBAQg?=
 =?us-ascii?q?NCQgphUCCOikBg1URfA8CJgIkEgEFASIBNIMAggsFol2BAzyLJoEyiGMBCQ2?=
 =?us-ascii?q?BSBJ6KIwOgheBEYJkiD2CWASBOAEBAZUsllQBBgKCEBSMVIhEG4IqAZcUjiy?=
 =?us-ascii?q?ZSw8jgUaBezMaJX8GZ4FPTxAUgWmNcVskkhwBAQ?=
X-IPAS-Result: =?us-ascii?q?A2EVAwBIoJtdh8fQVdFmDoYghE2OYYUXAYZ3hVmBGIo0A?=
 =?us-ascii?q?QgBAQEOLwEBhx8jOBMCAwkBAQUBAQEBAQUEAQECEAEBAQgNCQgphUCCOikBg?=
 =?us-ascii?q?1URfA8CJgIkEgEFASIBNIMAggsFol2BAzyLJoEyiGMBCQ2BSBJ6KIwOgheBE?=
 =?us-ascii?q?YJkiD2CWASBOAEBAZUsllQBBgKCEBSMVIhEG4IqAZcUjiyZSw8jgUaBezMaJ?=
 =?us-ascii?q?X8GZ4FPTxAUgWmNcVskkhwBAQ?=
X-IronPort-AV: E=Sophos;i="5.67,269,1566889200"; 
   d="scan'208";a="80773786"
Received: from mail-lj1-f199.google.com ([209.85.208.199])
  by smtpmx6.ucr.edu with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 07 Oct 2019 13:34:16 -0700
Received: by mail-lj1-f199.google.com with SMTP id r22so3872192ljg.15
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2019 13:34:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=VjVPBctNPhqavgf2eBQ5U1+nPWLcTDRc47SNVp//OKQ=;
        b=T2YO3pDQBbNmZl3ponBoEF/fGMAyif4eJ1dvWFiLJatp+5htTqn+nDFUStyf6QKo17
         Iu0kv8R7kawwA6H+fvk90FLp95xuMCPO9jpezXMgy0aFcreVJPKaiUN0TGwHZRG5YeQF
         WpDHpx9W06eINgBF3Zl4nASLJ6XxB5sjTh8Se+M7sDrGVcGB6GZk0m2Nr4tu9yCdTREf
         vDeAupnkPM6e+jCweKXOh7oOz3hSwmkBQAM9Cpn+TWJgeSS456GfrYaKBUCZl75zXxV8
         COQllblbI2Coi/YCywiLvEoDiPwPW77SJY9juybuJws0Jhl3q06U3zdpYOjfsUdSxPNp
         ATQA==
X-Gm-Message-State: APjAAAWAM+RQXWy/Prvxjm2EDdNIJmhLtgqAN4R45OLi4XaP7jOPBgcX
        ibbHTl4G2QEnSUdIZOTfe4wvvxueP5qiElQErNMsHj+spnZU5I+0ipNgaEN4Ews0Volyq4sZM80
        AAtUM99ynxiB+2OAmpnH9RddPeBHgbpaKCnz17xHVOg==
X-Received: by 2002:a2e:7611:: with SMTP id r17mr15058309ljc.133.1570480453184;
        Mon, 07 Oct 2019 13:34:13 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwE73u+4iftMlE/s9XRgsWcovJSqjKS0oeZU9K2kgJOCIbYMoFo5zj1EXxuEGUsA9dh9d9KBp39RyTjGkAFTPY=
X-Received: by 2002:a2e:7611:: with SMTP id r17mr15058301ljc.133.1570480453012;
 Mon, 07 Oct 2019 13:34:13 -0700 (PDT)
MIME-Version: 1.0
From:   Yizhuo Zhai <yzhai003@ucr.edu>
Date:   Mon, 7 Oct 2019 13:34:56 -0700
Message-ID: <CABvMjLR+oYb_kaK5zUHhVhcB7a8vRj=ZJrRWahCFi9B5_YCsqQ@mail.gmail.com>
Subject: Potential NULL pointer deference in scsi
To:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Zhiyun Qian <zhiyunq@cs.ucr.edu>,
        Chengyu Song <csong@cs.ucr.edu>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All:

drivers/scsi/scsi.c:

Inside function __starget_for_each_device(), dev_to_shost()
could return NULL,however, the return value shost is not
checked and get used. This could potentially be unsafe.

-- 
Kind Regards,

Yizhuo Zhai

Computer Science, Graduate Student
University of California, Riverside
