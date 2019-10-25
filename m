Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C50FBCA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 13:55:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C70A21D7F
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 13:55:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="Yykzode7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2505202AbfJYNz5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 09:55:57 -0400
Received: from mout.gmx.net ([212.227.15.19]:49741 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2505113AbfJYNzo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 09:55:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1572011730;
        bh=9ZX9RlREpwyQtZ8vBq/razbq3sDXMud2kIHv3bYsfgg=;
        h=X-UI-Sender-Class:Subject:From:Reply-To:To:Cc:Date:In-Reply-To:
         References;
        b=Yykzode7tpUWi6O4QGEvkGXPIGjjZ5fk6fNJE1exbY4VLdsNBrZAEnGUD+Vch1+mN
         bHJYWbSYL71uw/dW9OSDeYVCNg5AI8mqn9moUXfeMZ3Q+dErHLupTtOYODlOHZyb2D
         03lBioZjIj3bb/6BOjLu2rijBoGSFJTidaj+au74=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from bear.fritz.box ([80.128.101.49]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MNKm0-1ickgq3bBq-00Ooc9; Fri, 25
 Oct 2019 15:55:30 +0200
Message-ID: <8534fa18abf0b586690355e0441eccc96d1ca2b9.camel@gmx.de>
Subject: Re: mlockall(MCL_CURRENT) blocking infinitely
From:   Robert Stupp <snazy@gmx.de>
Reply-To: snazy@snazy.de
To:     Michal Hocko <mhocko@kernel.org>, snazy@snazy.de
Cc:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org,
        Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Potyra, Stefan" <Stefan.Potyra@elektrobit.com>
Date:   Fri, 25 Oct 2019 15:55:28 +0200
In-Reply-To: <20191025132700.GJ17610@dhcp22.suse.cz>
References: <4576b336-66e6-e2bb-cd6a-51300ed74ab8@snazy.de>
         <b8ff71f5-2d9c-7ebb-d621-017d4b9bc932@infradead.org>
         <20191025092143.GE658@dhcp22.suse.cz>
         <70393308155182714dcb7485fdd6025c1fa59421.camel@gmx.de>
         <20191025114633.GE17610@dhcp22.suse.cz>
         <d740f26ea94f9f1c2fc0530c1ea944f8e59aad85.camel@gmx.de>
         <20191025120505.GG17610@dhcp22.suse.cz>
         <20191025121104.GH17610@dhcp22.suse.cz>
         <c8950b81000e08bfca9fd9128cf87d8a329a904b.camel@gmx.de>
         <20191025132700.GJ17610@dhcp22.suse.cz>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:u7Vgsxlud6XI8Pq7y2tuCkslo2bG6hGtqcWfHx+KA7pi0+PHEYx
 a09WBHs+j1qA0LPVEnGJ5wLoCjbtB8Cy7LLPMMs+MPCzip7ndGdzhCj2+ggczscTa1knhvm
 ZZT6Rx/fuXdotVJ3M8Fqm1F0Ds/qxFPHp65KO9lU6Ux6vy9kDFKmdezxudYAQHcG3Tb+tJa
 Qaihmc/KsJGePqSZzc8Fw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:fW6HAR9cnRU=:51wgE3xaOojpK9VWIdew9o
 MyWo0BKaiTwokyTybxWW7aMuRKLwoQzmFSHek6ZzUZJFlTu/59ZI0/8x322O1izTj6ILH29s5
 ccaOHosVurlV3CciVGNofecu6ToF+kd4xznXatszsnTZ3P900OswMsRYbrR1OlPYazMUd0oxW
 57qQQ1UUNmzBj51cED2kTNIm7YDTPMmo/W1AFDMX/LHC6Y01unPAPoM2zjU7IoVrk/FMTmUqs
 OyvzuB02bYVhyNn8L04ba8K0iOLPsiGdgnRG4xauTjGRtCTJjld4wn1ZlYCOxO/GzGd0pFtcP
 OV7PXu+ieiaPCidCQktFNbBeRyCp7M4O8V4C3xIWeVz1S94NrqkPooMjY2mloUMV4jZygR8Ub
 ZpoNwyHtm2P8CgJqKAeiL3MpmJdwUnG0BIgl1g3yMB5Fl//pO1jnPZalDKTQS4n3YAx/ETpBF
 LTKyEJE5sQjFTCa9hQ6TiqmWfMOxR6JGIdQ6f6xDg/mNwXQkf1ViNtCG9jpgaEfHqM8CkdSn3
 2rMeETZ/DqBo7uvODyEU1gfGDTeoNlnTJf9OQK8BuyhtmM3gdkLpnDcGo1bQQdyLZXoBhmI0y
 yBUZmUUnzfkGfr+KXUC2PrkaNFG6M+CJn2AR6n5yNRUNnUBig8oujKn7Iv56KtMCsP2GQIbBO
 ZwO5bMUuipXGaAPUutnTKttKv+sVeEoAd1cLhtMK/0EL1493ZKYdinbZRorvH9Ut0u+sNCtXw
 OM1YpNXJ7oHr8epoHa0DR5DvEKVY4U/OTAJZLRaCoqE78D0hpK1/9JfIZ2ESoQLmDioLvpTSQ
 PyMzg1JyXJlikTRK8dx454/X9uBX8ALGSeOeyKQQw3UGL2x3+/mW9HX5nnZMPe4JBMV6adXtK
 d1m7jZdUJ4vGYvd6NkUlIO+2SvIB+BsZtr3Vsyr3yPuQ2bNwiSBjLQditiPuYUxxSeVgd7xSx
 NVuMAnYG+/Ru55Ah/V/HVhjWPHYuJcmBiEswOpgTdSk4pZbrF3sCibrh6Ztl2Jowi7r9XQaRx
 pWbJg/MvFnJnhPjrxKFQsSTG7799L64x3ZpqTziDHYOS3rwNFHT0tqtbsdEjfVnh1cZ+MjVf5
 R9F37YlE1JsWIojhQ+zVbhMzvDoqT4ibbiKb7pEtQ+wmApqbF1JkvMd+U73smVkuBkNQkDp26
 5hcT55Xirnv6BpBqnEg0/K36y82OckHKLNbJDkwzh6nZfwEZEBZMKeQD30l+jtjjg0glMOf4U
 CuNdp8ZoaIMI1r6SIAWm1gih+baLV5S6aNU9NkA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-10-25 at 15:27 +0200, Michal Hocko wrote:
> > Pss:                   5 kB

Seems Pss==Locked is wrong here - or better: it doesn't look right that
Locked==Pss?

