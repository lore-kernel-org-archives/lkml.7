Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1DAECA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 12:18:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A92C62070B
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 12:18:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IYbiDOcb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440163AbfJYMS1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 08:18:27 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:50158 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2436740AbfJYMS1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 08:18:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1572005905;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oILhUWc15hrlEafGCSI3TeVGDrfMDs173wP6QCUEDhc=;
        b=IYbiDOcbJ8ocN3P8ogRckDI/+F/ISYaP92kfstCkR6X7m/mZ+LBbC/eMxp1W9/x52tmFqz
        uF3ni8ooMQTtaZ6SIAgk91vSdhc2AHVEZj6e2dEx2LpVJwkzCYxJvePOBm+Ugu3ceY0cC7
        SiYV+MHbuvxUY57DPv0SFN1bOgl4BwY=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-273-YVMYoSSPMwWYmzh7TfazJQ-1; Fri, 25 Oct 2019 08:18:21 -0400
Received: by mail-wr1-f70.google.com with SMTP id f4so1017076wrj.12
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2019 05:18:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xfkNM/istIu3JD5LdamXLjkruNM0tLH0mkQIXgCY5KA=;
        b=mLqIj/kNul9H4DLwGJmZUXEQGV9Bbjc6RPYRSaWxCSCx+sva06l45jMbL7gLhlJbLk
         h0OnqByiZkIeFtZbm5CVUQQU9wNt669wGBUT/3GOG2SaO+aKURMUC3LdcDkSYG5cmCLr
         xH+PQhuB2onmtCxqPi5EWk74aAtbcVq1MQZLWKKtLqq1GRRqA4FdcZ2N3zSSjJMTpCHq
         3ALurlteMLqa7B9cw0oGuwKY1IlsmK5ah12baBpd2f1Tr5+rmL8uQXpHZcTgFXl5puLO
         HMux/WWT3aWZAYz4UrOLQ9Fy/2ZLpYJ8RYpcLSnzuVcPKAZsm/B/klJhRcr1lFAASXVp
         b++w==
X-Gm-Message-State: APjAAAUI5vNhGAIpZplgxAIRmWLb7un8BSR8wuSc7qPF9vj75AjC7W4P
        HsBIQP9ws80zOxSYCr1WkwJyCsfee0sVf3e6bmssJ6rIa11YI1/5Y1o6Hk6uI657yxX2R2mRGpW
        DYi3bQYJ6KFDkyKH7ShDPVECF
X-Received: by 2002:a5d:4803:: with SMTP id l3mr2775130wrq.381.1572005900889;
        Fri, 25 Oct 2019 05:18:20 -0700 (PDT)
X-Google-Smtp-Source: APXvYqw7HQYZLS8VQ9JQ1sGnu+Dr/dx2HgyiEL2N8s4h8fOPpt+3D4sG8/6puIsNHlO94Oa8yCOJ2g==
X-Received: by 2002:a5d:4803:: with SMTP id l3mr2775108wrq.381.1572005900701;
        Fri, 25 Oct 2019 05:18:20 -0700 (PDT)
Received: from shalem.localdomain (2001-1c00-0c14-2800-ec23-a060-24d5-2453.cable.dynamic.v6.ziggo.nl. [2001:1c00:c14:2800:ec23:a060:24d5:2453])
        by smtp.gmail.com with ESMTPSA id v128sm2703311wmb.14.2019.10.25.05.18.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Oct 2019 05:18:20 -0700 (PDT)
Subject: Re: [PATCH 0/2] add regulator driver and mfd cell for Intel Cherry
 Trail Whiskey Cove PMIC
To:     Mark Brown <broonie@kernel.org>
Cc:     Andrey Zhizhikin <andrey.z@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        lgirdwood@gmail.com, lee.jones@linaro.org,
        linux-kernel@vger.kernel.org,
        Andrey Zhizhikin <andrey.zhizhikin@leica-geosystems.com>
References: <20191024142939.25920-1-andrey.zhizhikin@leica-geosystems.com>
 <20191025075335.GC32742@smile.fi.intel.com>
 <0d3919c9-40e0-7343-0bbc-159984348216@redhat.com>
 <CAHtQpK5ZSOMKY4U0y-HHHH6QiuYRWHr90SAzjaACpAGgTzALLQ@mail.gmail.com>
 <0136a15a-7af4-dabc-a857-fcd80d5576a9@redhat.com>
 <20191025120506.GB4568@sirena.org.uk>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <88c831c8-5c9f-13b8-f500-6e12e9527a9f@redhat.com>
Date:   Fri, 25 Oct 2019 14:18:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191025120506.GB4568@sirena.org.uk>
Content-Language: en-US
X-MC-Unique: YVMYoSSPMwWYmzh7TfazJQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 25-10-2019 14:05, Mark Brown wrote:
> On Fri, Oct 25, 2019 at 12:45:30PM +0200, Hans de Goede wrote:
>=20
>> Hmm, I do just realize that the regulator subsystem turns off regulators
>> which are not in use from its pov, which would be kinda bad here.
>=20
> It will only do this for regulators which have constraints which
> enable the kernel to change the power state of the regulator, the
> regulator core will never make any change to hardware that was
> not explicitly permitted by constraints so should be perfectly
> safe unless constraints are provided in which case it's up to
> whoever provides the constraints to make sure they are safe.

Ok, thank you for the explanation.

Then I believe it is fine to keep the driver as is, with support
for all regulators in the PMIC.

Regards,

Hans

