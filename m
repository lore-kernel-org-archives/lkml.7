Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B54EC282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 12:48:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4162224987
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 12:48:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=raspberrypi.org header.i=@raspberrypi.org header.b="m8hGAbc7";
	dkim=pass (2048-bit key) header.d=raspberrypi.org header.i=@raspberrypi.org header.b="UAFK3f55"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727732AbfFDMsl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 08:48:41 -0400
Received: from mx07-00252a01.pphosted.com ([62.209.51.214]:58070 "EHLO
        mx07-00252a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726994AbfFDMsk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 08:48:40 -0400
Received: from pps.filterd (m0102628.ppops.net [127.0.0.1])
        by mx07-00252a01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x54C3fT3009824
        for <linux-kernel@vger.kernel.org>; Tue, 4 Jun 2019 13:15:26 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=raspberrypi.org; h=to : from :
 subject : message-id : date : mime-version : content-type :
 content-transfer-encoding; s=pp;
 bh=eMleS+sVc7Zc0KhR3uyqsACYApIneIVmc3GHjPGqrDY=;
 b=m8hGAbc7piD4I8YIin4BLF5Q2Lh0qd2mi4kUK1tjBSA1Xr1n493QAvBHk89kCo7EkPSN
 DT0YqnQKaQsxF0qe1x81QYluHMcoz26L3eE9f4aH38Y2OVEyc11XnMCm59aA1rciQzAq
 Bv6bJkSOcMXs+E+GqnMZWPMwZemfgE42g3i6qBS1UbR7i/VcnfizFo3tXHKARN0amI86
 zhimPkzXw569K4TvlxfVwM9kS/Q5IF0QQpp5YeuZLnn6tjzyrgK3YrbIkhUaf70m+wwo
 WFZbvvVC9FqD7CILUGzLL3jATT0zibUP39bPXGzyi12X+qsD+HSGxzO/KltftAH8pY0k Wg== 
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com [209.85.221.69])
        by mx07-00252a01.pphosted.com with ESMTP id 2sues31h2a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK)
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2019 13:15:26 +0100
Received: by mail-wr1-f69.google.com with SMTP id i11so4095883wrm.21
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2019 05:15:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.org; s=google;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=eMleS+sVc7Zc0KhR3uyqsACYApIneIVmc3GHjPGqrDY=;
        b=UAFK3f55FN4X7/3h+WMHvJ3diLRNNMUPV+7au85j95UyUkIoi9RDMD9sRbsQ+HzpgJ
         p/+8i1x10zvy0/PIRHtadUnra8gWO+RrKY2hHTifTUiygbQpDEiPG6pXLsryBJjFiz2S
         H2gg6k0JkQkK+azNIWoQZeD7w4rtGHp74nW4+WtngY/LZc9c0TgKzfe16u7KlQeY4ibD
         LHWXDfr1CFP4k8uvysBX9aYSzY2jeB8GztL3kdHQS1jDe/WIAK/GMeC/us9GRQt6a85e
         loBWGpD7s3OHykUEM3wlLaLHbKa3UcTnOE19lhXLbaQTYxykVMOWPz4DQZHsY7yy8cao
         +94Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=eMleS+sVc7Zc0KhR3uyqsACYApIneIVmc3GHjPGqrDY=;
        b=CbiopfLLAXbbfifcDOSNUFQJf1f8HembOeutWaa2GNZ5C7gcGFDRaJ0xqmf7VfF5SD
         kT+UaKWfM3lu7/iTC8zymGBcanA1Xw9BGO4QoLmzqpLp7rCh3tL5jbNKviEgoHHId5Zt
         UJbDWUl9C58LJkmfaVElnPlPDnbZkUcUBP7UkvoyJuoAQIF5smSkbb4HTcCbd6O7Mu/O
         hn1GffoFmrig3PbGZHA6mFKpJfdkpToh1aLbeCvjhEoZEHg2YLcJN5aNb0Nra3Ohe3LA
         DvBObchEQJ2yhzPGISp6QitwMnNYiE7HeTkULWXzn/GE3pc04EUESzs5uSbxHCZdx20K
         yIkg==
X-Gm-Message-State: APjAAAXufIH8IOg9e9b//82gMuZT75pugB2BBOQ0dsGvmId/+CkVYNZR
        UPynAZMdroZZMMptZ0h0Y/UwKGAa949Ieg2cReKvGA3DxW3hlf0XbSLVnKUB615pw7y2DgSHErm
        hMY3Z2fC8QlkWd9nJv6wmEWmn
X-Received: by 2002:a1c:108:: with SMTP id 8mr13418779wmb.159.1559650525706;
        Tue, 04 Jun 2019 05:15:25 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwCSywJvJnulKM73GRNdBSWFHfcr6xhEHVCFp2sTrq2mUbutFfMvN9VAsPHz3ylgA124a9ZaA==
X-Received: by 2002:a1c:108:: with SMTP id 8mr13418764wmb.159.1559650525426;
        Tue, 04 Jun 2019 05:15:25 -0700 (PDT)
Received: from ?IPv6:2a00:1098:3142:14:2cbd:20df:89bf:def2? ([2a00:1098:3142:14:2cbd:20df:89bf:def2])
        by smtp.gmail.com with ESMTPSA id 65sm33948458wro.85.2019.06.04.05.15.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Jun 2019 05:15:24 -0700 (PDT)
To:     Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From:   Phil Elwell <phil@raspberrypi.org>
Subject: Dynamic overlay failure in 4.19 & 4.20
Message-ID: <c5af11eb-afe5-08c4-8597-3195c25ba1d5@raspberrypi.org>
Date:   Tue, 4 Jun 2019 13:15:26 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-04_09:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

In the downstream Raspberry Pi kernel we are using configfs to apply overlays at
runtime, using a patchset from Pantelis that hasn't been accepted upstream yet.
Apart from the occasional need to adapt to upstream changes, this has been working
well for us.

A Raspberry Pi user recently noticed that this mechanism was failing for an overlay in
4.19. Although the overlay appeared to be applied successfully, pinctrl was reporting
that one of the two fragments contained an invalid phandle, and an examination of the
live DT agreed - the target of the reference, which was in the other fragment, was
missing the phandle property.

5.0 added two patches - [1] to stop blindly copying properties from the overlay fragments
into the live tree, and [2] to explicitly copy across the name and phandle properties.
These two commits should be treated as a pair; the former requires the properties that
are legitimately defined by an overlay to be added via a changeset, but this mechanism
deliberately skips the name and phandle; the latter addresses this shortcoming. However,
[1] was back-ported to 4.19 and 4.20 but [2] wasn't, hence the problem.

The effect can be seen in the "overlay" overlay in the unittest data. Although the
overlay appears to apply correctly, the hvac-large-1 node is lacking the phandle it
should have as a result of the hvac_2 label, and that leaves the hvac-provider property
of ride@200 with an unresolved phandle.

The obvious fix is to also back-port [2] to 4.19, but that leaves open the question of
whether either the overlay application mechanism or the unit test framework should have
detected the missing phandle.

Phil

[1] 8814dc46bd9e ("of: overlay: do not duplicate properties from overlay for new nodes")
[2] f96278810150 ("of: overlay: set node fields from properties when add new overlay node")
