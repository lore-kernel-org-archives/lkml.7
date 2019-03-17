Return-Path: <SRS0=5V/v=RU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FREEMAIL_REPLYTO_END_DIGIT,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70FC0C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Mar 2019 12:14:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BD582148D
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Mar 2019 12:14:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="skGyqNWt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726850AbfCQMOa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Mar 2019 08:14:30 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:37868 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726092AbfCQMOa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Mar 2019 08:14:30 -0400
Received: by mail-wm1-f68.google.com with SMTP id v14so1454027wmf.2
        for <linux-kernel@vger.kernel.org>; Sun, 17 Mar 2019 05:14:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:to:cc:references:from:openpgp:autocrypt:subject:message-id
         :date:user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=GNjKxL9i5ilqXhcSpzcvW63dchvu4lEVW4q5SY8x7q8=;
        b=skGyqNWtTKt+1+pWs/c1PU2tgxaSOFNLrWy+GjV4gKSKu50YPu1k5aZSx8qr9hzLDd
         taSe+XSsf8ts+TJNQ+21Pist7GreUx6SJgw40ISgz6kGbNrmnb5VAusAqGGSNf3miCVS
         gXWAESlG2TQhxCfxKGkeMnjkWZP7QE9pZBiMUzFwh9tg9OeWK1rBWC3Cm9afUBEhkyKP
         9qGNXPlKw/CEef8qzCxTNsgzkxFEEEdWT0qFpSBxUp+/WC4aSJibEQAT30cG/9rFvPcJ
         HCJOlJtvn2+CJhxPeSMTgfbtfF/yrGsWlXuAQ+JkNHtwU1TSLaMWMIpubqfSrYZKHY5o
         Lu2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:to:cc:references:from:openpgp:autocrypt
         :subject:message-id:date:user-agent:mime-version:in-reply-to
         :content-transfer-encoding:content-language;
        bh=GNjKxL9i5ilqXhcSpzcvW63dchvu4lEVW4q5SY8x7q8=;
        b=A880QQd4Z7QQmA1pkLi+8uh1AHfFRJCza+0ad8DYkLCrlhOY0IRjtErQu4fDitpozC
         SD7hOnsE8VNrR2R38yPLGKq/Yo8eigZPAcmoPlTi5hwDivYeXQ8qdw44U/J+A7fJw5t+
         7Q/edQLhl9EnTsUtk67rqM9DuCNDQAD/PMQeYR4QcCZDPsfeIzmqC8XgijYz1A9f3mmn
         zTm2CwaH2IGTeaJP1ytFP/sT5x1/dwemrM3hh5Kj6L0keg0B4vxI+O5W83lZuWGlBq99
         LxK4qO7f+h+Q4BZkSECSjJ/hs6UiTLQIYbune7nyOqA+gwklOrnkOy+wz83UHrFg5ULf
         ZwcQ==
X-Gm-Message-State: APjAAAW/h5MXGE1yP+Qmw158sNZLo1DgM0zmm6ZQOK1LfQKQZRWRM3Zc
        btFt/gUURsE2I7k5dH5lCCPsZipGUiI=
X-Google-Smtp-Source: APXvYqxlTOUriIo4NPlp2ldVJnfUmzMfXvFbaQQojO2OiDEIVayyE1cLknJ+NOf0zhD1VGJzt/wMGA==
X-Received: by 2002:a7b:c08a:: with SMTP id r10mr7607444wmh.112.1552824867623;
        Sun, 17 Mar 2019 05:14:27 -0700 (PDT)
Received: from ?IPv6:2003:c9:8705:f800:b437:96a8:f694:85b6? (p200300C98705F800B43796A8F69485B6.dip0.t-ipconnect.de. [2003:c9:8705:f800:b437:96a8:f694:85b6])
        by smtp.gmail.com with ESMTPSA id n11sm21033063wra.94.2019.03.17.05.14.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Mar 2019 05:14:27 -0700 (PDT)
Reply-To: benniciemanuel78@gmail.com
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Eric Anholt <eric@anholt.net>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
References: <20190317015930.GA1747@p200300EEEE2F.fritz.box>
 <20190317095502.GC6906@kroah.com>
From:   Emanuel Bennici <benniciemanuel78@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=benniciemanuel78@gmail.com; keydata=
 mQINBFtz5w0BEADgO/3VL41lNZuj9q3H/FguKgmnwkiAhicyRXPZesQh/xptO8g2lQSN5QAE
 S89H9K6CC3iiwOEJRAKy8s/aZnBIB1g6iRoqF6LM2RtU5EYgePGmYp6Pl71V0mqbT38NyvEY
 VjR6fGFnzSMavfYbAdG3nVzFKSLffNFKw3usTBXoFdd+43+Nw3BsvVMN3Y4HPn2Dr4+ubkON
 D5pcJ1ARgE4PAOTAOUE/QMKTyOzjPVz8XhYNQ7ZGdGdAMjl6QCKGqGw9h1bgzJHh2Lr7QLIL
 lTzpEnVZmIg355m+7HwutknZTsGDgotvImZ55ps/6KKiCPxn0FavOW3okV3ROihWCSpeBqVW
 ibGFfC8FIT1CK38wuacFoeWvISgUtKH9hjM2pDzSspytXn8Nrhq4R776I8iZb+rd0Lt7wxR6
 L+HfQ3OnCjCfNTtBBYhLpRv2/aKnucWrexls0C4j5ljomq3fhnOR+psiCfRPhFs7ZgWdpk/9
 IUthrSMbOzp0X0ve4aTdoZSuqFs5M6PugXJQHlH/gQf2dEeOj0j8X3ej6a0NP1prF+V/jqcB
 mQnWZMUFjFTn1R0b/I7sL7FHrdeUWKq6xjup0xbXje8sRtdvONjcvp+FF2Wm1UlkwN+PaxYA
 /3zMkXrCF0eld1nLz4OIjDR5E7hVSR2rwWsLw72Ux75chh0njwARAQABtDZGcmFuY2VzY28g
 RW1hbnVlbCBCZW5uaWNpIDxiZW5uaWNpZW1hbnVlbDc4QGdtYWlsLmNvbT6JAk4EEwEIADgW
 IQS2Q0nGtlLNEsA/2s0X+i1WutAWYQUCW3PnDQIbIwULCQgHAgYVCgkICwIEFgIDAQIeAQIX
 gAAKCRAX+i1WutAWYdBtD/9f7CvpaEnI35itV6oQiKEcls2z8mza9lK4G7MXOdqrqMirtDmT
 /mQ099UpmQYbzyS89pnTc5BoJQ4HRnKLOL1pY7+bDUbjllrHZMtIxZ0ZXpMbgIGtzx69dTUB
 VOl87GcZpLOKwc+ODv8r2QJR/5iMwpZmb+0zGLQ0rSJizkbsgQMqYNWGOWkm6luK/8M4hmTe
 PTU4iFbYAN3X/6wY0KbC18b2kN9eWbpZBURDpE1w+p6rS7HOYyNjgYpIxduOQNTgrhrxWnRd
 ZS1UI3eTyhuN+xj+Wc4rXbSR0rHL2BR7lG+1rqnmqZVjlORsU9QmikQU4IqdNhqJHv3mb+1p
 wLE8K0sbdcmBBsW788I/05dUMs6FCgGU9uyvSVEUS+qdCzSAsvx1hqf6AO1erPpNF1aLxNZc
 iOB8zJbk6YFDCWXMy+ZaAUnr2gG2eY5P5l6E8BZ7kd39OEt7B3CIduLfwvG1aRF9V6DHAeT3
 aOGMAFzetFI1hBypYdIzbiljkfY69gsPFEQnlfaLEVLVraRUxW85xqrH9LBo46gWEV94bjUV
 1vGSrwk7tVstS/yZQUBhNxlFjULdI+nme2VmGZ7EIcdA5IozYEsC3lsNhZqB+JN8rwrz2CzA
 aCBDgerWGs/LgViYxyhHrf3EgJ4nO4n/042uBkhPfLMmRcddZqoogI6zG7kCDQRbc+cNARAA
 uQMkklmyQN3lu6uuQSI1Mqu07PK/cZC24paiX8pheZxuEN9m/m+xflr6rhz+qmWfnczDfvf5
 LRvCdsoWdTd1cTl4ogMOgesYndFoq+547KNRXB4GeNZplmAqufEtt08H5tonkxWFT38aUH7S
 c25Hoqj1rXPOJAYYNd8d0D0MBJ+KSiBSn+SHlEbC26igOaXwA2qe7ULxSGnYZpBHC02pdGZc
 ScjK8CxGgO+O/85QAPPlCgGfUzj48RI/8Lohojmgd4yG4Cgr2nWgMIZ7uMdixRQgMBIXjv0a
 vkLjzo+cIjZN32Q4xBMl0wecVxBb1dBWnKRBPiYHdIW//rlldGO/q7EYU/rfKqtR/9al94Bp
 DIGrI6Eqxu7/O4RDozpZw4UCQjs3Rr69GA7niD7O3R/NxTGOfAaboRxPjfBWav0JbO8FZKUR
 gQ3ofp74fERzd/gm9+xn7OxVtdmWC+KSbbGS0x5SAyL3J8zAnbM/JYR5U76sM0UnYACqlTrB
 /fkBacORJqh+CPJZ9eyu9qxv6WcUqiXTVD37+R8DyTSzmnaskrIHgi4z+aSs1gMju7/ejXqL
 9qfE/UXt7aSRl/5nyXWkucPolGvl1kDWQJydaASFwiemYPia6UMe8t/5EmkTp35qBEWg8z2e
 emkh4EBLphs/9cZSmqZH3wTITQ8+MfaOjY0AEQEAAYkCNgQYAQgAIBYhBLZDSca2Us0SwD/a
 zRf6LVa60BZhBQJbc+cNAhsMAAoJEBf6LVa60BZhA2EP/37esO2zUVybMi4DW+5rdy89YwMM
 r7aWzt2gd9HUFG+S3L5bWIrJQ3RExTXIKXhkc6pNJc203Jb+jOVoWI5cANd3eXyJuKF+8XdE
 SAY1Hh5XIKvfsQuBonXwcoVNiXta4lYcsz0/MyKUnE4ySE3UIvsIHWIIRRt/Nl2MbXq7I21I
 Z1NDhu4X/KLbmE/cplbxaFMhqcU7JhuhhqjN4HRVr3AZ3VE7nyKVBWd/Wwv6u4als5Wf5jsN
 +tawnRMUfc7HX7DBtx4pOGdQxxiY0sopiLnWNdDkFe9W9GXYJ1fH8dUfHu7kAgkbAjt55veF
 YCw2gzEI4OttlSjbmj5XF2P25u5+F+tpT+D5ev8oR8/LbV63MnVkJe/YT/JOeeNMDpbGOxTx
 0vVVCKr76wiTchvqUcDEqFCRF8NnIh+ESPPGMrYdvrgybSBPQEmBgzq+ado5pbkr9eRUMJHH
 lSYTGgtM86BgYsXFgK7M0kI2qD67nrNTgvReKzGyIzs5MGACo7hxMes6CctoU4AEoBa+vZX8
 cFjuvF07oRZKwSVzd6fQy4Pq0p1VJrJXmxVLCXNmw/Joa8xyFbjlsktYOnqhBfwa7OZkwKxn
 IvrtJzTQte390ruJPJOL/1t+LT3nPB6SXMxTXsCUinYnPveRZyfuLqhwqNkZxnotJNbFW/9K
 /m/WpMQm
Subject: Re: [PATCH 2/2] staging: vc04_services: Add blank line after struct
 declaration
Message-ID: <e62c9952-190b-d232-4987-5e1a05e16a57@gmail.com>
Date:   Sun, 17 Mar 2019 13:14:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190317095502.GC6906@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Am 17.03.19 um 10:55 schrieb Greg Kroah-Hartman:
> On Sun, Mar 17, 2019 at 02:59:32AM +0100, Emanuel Bennici wrote:
>> Signed-off-by: Emanuel Bennici <benniciemanuel78@gmail.com>
>> ---
>>  drivers/staging/vc04_services/interface/vchi/vchi.h | 1 +
>>  1 file changed, 1 insertion(+)
> I can not take patches without any changelog information, sorry.

Add blank Line after declaration of struct vchi_version to fix checkpatch=
=2Epl
Check `CHECK: Please use a blank line after function/struct/union/enum
declarations`.

Signed-off-by: Emanuel Bennici <benniciemanuel78@gmail.com>
---
=C2=A0drivers/staging/vc04_services/interface/vchi/vchi.h | 1 +
=C2=A01 file changed, 1 insertion(+)

diff --git a/drivers/staging/vc04_services/interface/vchi/vchi.h
b/drivers/staging/vc04_services/interface/vchi/vchi.h
index 7b13cb04c119..43eaf7703777 100644
--- a/drivers/staging/vc04_services/interface/vchi/vchi.h
+++ b/drivers/staging/vc04_services/interface/vchi/vchi.h
@@ -55,6 +55,7 @@ struct vchi_version {
=C2=A0=C2=A0=C2=A0=C2=A0 uint32_t version;
=C2=A0=C2=A0=C2=A0=C2=A0 uint32_t version_min;
=C2=A0};
+
=C2=A0#define VCHI_VERSION(v_) { v_, v_ }
=C2=A0#define VCHI_VERSION_EX(v_, m_) { v_, m_ }
=C2=A0
--=20
2.19.1


