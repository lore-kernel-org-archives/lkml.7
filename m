Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BE79C4360C
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 08:26:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28712215EA
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 08:26:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=skogtun.org header.i=@skogtun.org header.b="nHsyrmql"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729806AbfJDI0o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 04:26:44 -0400
Received: from smtp.domeneshop.no ([194.63.252.55]:52137 "EHLO
        smtp.domeneshop.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727242AbfJDI0o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 04:26:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=skogtun.org
        ; s=ds201810; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Date:
        Message-ID:Subject:From:Cc:To:Sender:Reply-To:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=hqaOF0Jc026kyPgrqV255gF/o8CFEd4of8vrNrC3fjE=; b=nHsyrmqlGydmsUxFStKmWW4Gpr
        0HrIsAaOLu6HZS3a4UFWd7PVrqHba3a24imKG3HyvKgzspNhI+JOYsC+AkufUHrQFTtToYkMC5oYY
        3hBASOl2kLB01Te65H2Z049eH8X8hYUz6h9UHLPXWMktn5P8sHIgDM8gnZ+eZOctERlCmcgFaYeBO
        55RUg/cOee3RVwqlCuEUf+MmEXcydv1AbjyoVt35nodHx6fv25Rcbt5wrclggzfVfhu7S8TYTIGQT
        csxFIwVJAf6BFvczozef8ZxSrpxyxnp2MZ4B65rjewwccdQR7jHz0hccJGEhqMwo0qDV873nbVltd
        MfEIkXtA==;
Received: from [2a01:79c:cebe:b88c:caff:28ff:fe94:90a0] (port=48678)
        by smtp.domeneshop.no with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <harald@skogtun.org>)
        id 1iGIvC-0004Vm-GA; Fri, 04 Oct 2019 10:26:42 +0200
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>
From:   Harald Arnesen <harald@skogtun.org>
Subject: BISECTED: Compile error on 5.4-rc1
Message-ID: <cf947abb-c94e-9b6f-229a-1e219fd38e94@skogtun.org>
Date:   Fri, 4 Oct 2019 10:26:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: nb-NO
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I just tried to compile kernel 5.4-rc1 on my ThinkPad, which runs Devuan
Beowulf. Got the following:

$ make bindeb-pkg
  UPD     include/config/kernel.release
sh ./scripts/package/mkdebian
dpkg-buildpackage -r"fakeroot -u" -a$(cat debian/arch)  -b -nc -uc
dpkg-buildpackage: info: source package linux-5.4.0-rc1-00014-gcc3a7bfe62b9
dpkg-buildpackage: info: source version 5.4.0-rc1-00014-gcc3a7bfe62b9-1
dpkg-buildpackage: info: source distribution beowulf
dpkg-buildpackage: info: source changed by Harald Arnesen
<harald@skogtun.org>
dpkg-architecture: warning: specified GNU system type x86_64-linux-gnu
does not match CC system type x86_64-pc-linux-gnu, try setting a correct
CC environment variable
dpkg-buildpackage: info: host architecture amd64
 dpkg-source --before-build .
dpkg-source: warning: can't parse dependency -n libelf-dev
dpkg-source: error: error occurred while parsing Build-Depends
dpkg-buildpackage: error: dpkg-source --before-build . subprocess
returned exit status 255
make[1]: *** [scripts/Makefile.package:83: bindeb-pkg] Error 255
make: *** [Makefile:1448: bindeb-pkg] Error 2


Bisecting gives me

858805b336be1cabb3d9033adaa3676574d12e37 is the first bad commit
commit 858805b336be1cabb3d9033adaa3676574d12e37
Author: Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Sun Aug 25 22:28:37 2019 +0900
...

By reverting commit 858805b336be1cabb3d9033adaa3676574d12e37 I could
compile the kernel.
-- 
Hilsen Harald

