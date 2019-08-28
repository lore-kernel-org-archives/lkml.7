Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79F6EC3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 09:28:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DFCA217F5
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 09:28:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=163.com header.i=@163.com header.b="kklR9vR6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726508AbfH1J2S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 05:28:18 -0400
Received: from m13-114.163.com ([220.181.13.114]:12802 "EHLO m13-114.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726339AbfH1J2S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 05:28:18 -0400
X-Greylist: delayed 909 seconds by postgrey-1.27 at vger.kernel.org; Wed, 28 Aug 2019 05:28:17 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Date:From:Subject:MIME-Version:Message-ID; bh=/59wf
        BFSIWvpzMpbg4LzCXYv0HmrGhjiXyLTLxIdZaE=; b=kklR9vR6x3t2Hea3FnfaO
        PJkrUE8e+Ag9se9S9d4TI9A8ibxxcrXIkMTuRQhVbpOzfQP90Xvh5g61RvfkELdL
        Wp3vDiFFaID61bzgqrW10xU2yy/JX8Eu8kG7b7N1ZlXD9KQ2z0oZgis0N5MNS73X
        hnYPwFfCZXDBe8PUivO2c4=
Received: from csqshz$163.com ( [60.247.85.92] ) by ajax-webmail-wmsvr114
 (Coremail) ; Wed, 28 Aug 2019 17:12:23 +0800 (CST)
X-Originating-IP: [60.247.85.92]
Date:   Wed, 28 Aug 2019 17:12:23 +0800 (CST)
From:   =?UTF-8?B?5a6L?= <csqshz@163.com>
To:     linux-kernel@vger.kernel.org
Subject: [Question] What is the main function of sym_calc_value() under
 scripts/kconfig/symbol.c
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.10 build 20190724(ac680a23)
 Copyright (c) 2002-2019 www.mailtech.cn 163com
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <27eba10c.a74e.16cd77f5c79.Coremail.csqshz@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: csGowAAXSfh3RWZdyBXeAA--.60674W
X-CM-SenderInfo: pfvt2xr26rljoofrz/1tbiRxcff1c7LOQc3wAAsX
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CkhpLAoKCldoZW4gIm1ha2UgS0NPTkZJR19BTExDT05GSUc9IG15dG1wLmNvbmZpZyBhbGxkZWZj
b25maWciLCBJIGZpbmQgc3ltX2NhbGNfdmFsdWUoKSB1bmRlciBzY3JpcHRzL2tjb25maWcvc3lt
Ym9sLmMgaXMgY2FsbGVkIG1hbnkgdGltZXMuCgoKQnV0IEkgZG9uJ3QgdW5kZXJzdGFuZCB3aGF0
IGRvZXMgc3ltX2NhbGNfdmFsdWUoKSBkby4KCgptYWtlIEtDT05GSUdfQUxMQ09ORklHPSBteXRt
cC5jb25maWcgYWxsZGVmY29uZmlnCi0+IHNjcmlwdHMva2NvbmZpZy9jb25mLmMgbWFpbigpCi0+
IHN3aXRjaCBjYXNlIGFsbGRlZmNvbmZpZwotPiBjb25mX3dyaXRlKCkKLT4gc3ltX2NhbGNfdmFs
dWUoKQpzeW1fY2FsY192YWx1ZSgpIGlzIGFsc28gY2FsbGVkIGluIG1hbnkgb3RoZXIgcGxhY2Uu
CgoKQ2FuIHlvdSB0ZWxsIG1lIHRoZSBmdW5jdGlvbiBvZiBzeW1fY2FsY192YWx1ZSgpID8KCgpt
YWluKCk6IGh0dHBzOi8vZ2l0aHViLmNvbS90b3J2YWxkcy9saW51eC9ibG9iLzllODMxMmY1ZTE2
MGFkZTA2OWUxMzFkNTRhYjg2NTJjZjBlODZlMWEvc2NyaXB0cy9rY29uZmlnL2NvbmYuYyNMNDg2
CgoKc3ltX2NhbGNfdmFsdWUoKTogaHR0cHM6Ly9naXRodWIuY29tL3RvcnZhbGRzL2xpbnV4L2Js
b2IvOWU4MzEyZjVlMTYwYWRlMDY5ZTEzMWQ1NGFiODY1MmNmMGU4NmUxYS9zY3JpcHRzL2tjb25m
aWcvc3ltYm9sLmMjTDMxOSAKCgpCZXN0UmVnYXJkLAotLSBDc3FzaHoKCgrCoA==
