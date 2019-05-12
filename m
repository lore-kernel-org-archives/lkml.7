Return-Path: <SRS0=t4ha=TM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2256CC04AB4
	for <linux-kernel@archiver.kernel.org>; Sun, 12 May 2019 17:05:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE67A2146F
	for <linux-kernel@archiver.kernel.org>; Sun, 12 May 2019 17:05:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=landley-net.20150623.gappssmtp.com header.i=@landley-net.20150623.gappssmtp.com header.b="M1kb+HIz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726937AbfELRFT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 May 2019 13:05:19 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:38237 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726909AbfELRFT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 May 2019 13:05:19 -0400
Received: by mail-oi1-f194.google.com with SMTP id u199so7719587oie.5
        for <linux-kernel@vger.kernel.org>; Sun, 12 May 2019 10:05:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=landley-net.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=QSdaCWlLqhcDnznsymm2aG1Z95spPWEN1cuWFhXTYhg=;
        b=M1kb+HIzVOLjPCV4h6Pn4lve+FlnoRhh7JL/WOdRAHWhP7XRiXt2Sb1zCx+P73FWpH
         KH+vO3XX2/+B76I47eV+x5dE3f6pnMgrTIJE7VNh4ZChznUcTJY9sLB9hecdROdExjmg
         /JPQRL9+WNauQRy09PAuL4L+fpknOrj50gkModVL0BMNekoH7GBXdRdXfxoaLcWOG03L
         Y+O3tl58C2QvVdDq9MUnLdKYMn7lI9M9GE8l5NKOH1AX/WldekcH2nLERHsnEiX4sVsK
         tDUJ/uw9Na9lpPhy3YjlBknNgRsJ/+qzkinLg8HkU903BWLWhwIYA6J1YzU1WDzc0gEI
         hjfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=QSdaCWlLqhcDnznsymm2aG1Z95spPWEN1cuWFhXTYhg=;
        b=WL9HWoF1PBIiEOK7gFwGJhHSf83frxUvlfWg8ju92sfIKTlrDf2HHD03lxBrBNGMHv
         zEJr4wG4Nr/nfS4BJWFDlK5e9yWn/6JL1qTueMTMthzBzAGvikmO+sUAiJkkZG3K5Ql+
         Nyc3nChvu5Ou6edOQgr3Pu0s62EY2TX+l9ppyA9HhkqKuFuab+R77OWvc+D2Za0fkZYN
         4yidBrgrjZ7L1vFJMJSmSFPm8VaSIbmX/0rvGfr4nMngG9un/PjKPA5OTLnZMTO3OLbc
         kRgWy7zcwvUB1V2a5NSbZniH9dLjvie0ijL/Y5TlBt2o2NbQzmBFAB1ATVluRmfWeW8n
         cyIQ==
X-Gm-Message-State: APjAAAWVZ6v9IVDNqYAdBrSPpL7m1qQZnRnb6EByCzJ1z0300YyfTt3C
        h24j0uad1da0wV6Rdm/xtmiDAQ==
X-Google-Smtp-Source: APXvYqyWbK23VrEkToZOwoQB+/N6sOOi7C92304sjVSrsw7En9uosUTt+tMWJRIvjnvIj1tmphPF2Q==
X-Received: by 2002:aca:e594:: with SMTP id c142mr3854397oih.155.1557680718422;
        Sun, 12 May 2019 10:05:18 -0700 (PDT)
Received: from [192.168.1.5] (072-182-052-210.res.spectrum.com. [72.182.52.210])
        by smtp.googlemail.com with ESMTPSA id w192sm4456571oiw.57.2019.05.12.10.05.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 12 May 2019 10:05:17 -0700 (PDT)
Subject: Re: [PATCH v2 0/3] initramfs: add support for xattrs in the initial
 ram disk
To:     Mimi Zohar <zohar@linux.ibm.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Roberto Sassu <roberto.sassu@huawei.com>
Cc:     viro@zeniv.linux.org.uk, linux-security-module@vger.kernel.org,
        linux-integrity@vger.kernel.org, initramfs@vger.kernel.org,
        linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, zohar@linux.vnet.ibm.com,
        silviu.vlasceanu@huawei.com, dmitry.kasatkin@huawei.com,
        takondra@cisco.com, kamensky@cisco.com, hpa@zytor.com,
        arnd@arndb.de, james.w.mcmechan@gmail.com
References: <20190509112420.15671-1-roberto.sassu@huawei.com>
 <20190512091748.s6fvy2f5p2a2o6ja@isilmar-4.linta.de>
 <1557665567.10635.222.camel@linux.ibm.com>
From:   Rob Landley <rob@landley.net>
Message-ID: <dca50ee1-62d8-2256-6fdb-9a786e6cea5a@landley.net>
Date:   Sun, 12 May 2019 12:05:48 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1557665567.10635.222.camel@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/12/19 7:52 AM, Mimi Zohar wrote:
> On Sun, 2019-05-12 at 11:17 +0200, Dominik Brodowski wrote:
>> On Thu, May 09, 2019 at 01:24:17PM +0200, Roberto Sassu wrote:
>>> This proposal consists in marshaling pathnames and xattrs in a file called
>>> .xattr-list. They are unmarshaled by the CPIO parser after all files have
>>> been extracted.
>>
>> Couldn't this parsing of the .xattr-list file and the setting of the xattrs
>> be done equivalently by the initramfs' /init? Why is kernel involvement
>> actually required here?
> 
> It's too late.  The /init itself should be signed and verified.

If the initramfs cpio.gz image was signed and verified by the extractor, how is
the init in it _not_ verified?

Rob
