Return-Path: <SRS0=qvRn=2F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB7ECC43603
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Dec 2019 03:57:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D32F2465B
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Dec 2019 03:57:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="y8KYw7nx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726683AbfLOD5N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Dec 2019 22:57:13 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:35174 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726052AbfLOD5N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Dec 2019 22:57:13 -0500
Received: by mail-pf1-f193.google.com with SMTP id b19so3716826pfo.2
        for <linux-kernel@vger.kernel.org>; Sat, 14 Dec 2019 19:57:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=mD0Q7oQYjKwsMg2M4wabWtadHwqClbEf7Ae0x/K5NMQ=;
        b=y8KYw7nx/0imlHvkK8hcfnQhZoBnj7jpKV5qC1x6NGQC8eB6n7vZakzNmuQ1Le2rT8
         agP7oca0AxBdWDhYoxNvY2OReccDjAirKrxfSQe1ea23vsV+UQPVtVWpipKNC/dRAHRi
         CkJNBil5RyOEiEHC+hCZxmFIPWvmqoUxgPPEGH7DvA2sW9+jN5yIafikJvTjBwQ19zoy
         8gHmrVTo9uFx2nuIBH+IA2pFGIxOKK/czJux9fkqNLWH/p11Fo4wMGjAnN2Oyi9Nx6pS
         dy1WWvUZVAMkG2vqw1mDgzzhTveYPjVy2PeYEe4GV3BxfbiPQNtCU0jE3dciKcuq1NYK
         reFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=mD0Q7oQYjKwsMg2M4wabWtadHwqClbEf7Ae0x/K5NMQ=;
        b=EFvA61ozsKJbDhb+iXmkVy0Pcsyi/2zOKCSTeN7ZyXDYbOUnmhOpOI3PVSsperOWxK
         EGDF1JdUz+P+ijidknazW8AWWKFWKcoZPIuGJrWMZpB4Y+Rs8J5m8DJGpuxrGHtyraOn
         18QJ6qUc133UGpX2q4yLM3UhHnRdDFb8KyCjGxarlkoumqcxeT+hENXXhzdz2n7Bo/uE
         7k9W5/hUOAf3Q80pPHilo2laxSCQ2QoIKm0FvH0zqthYwCRbHTqwFB/neI5Iud35F4L5
         b4bn6G97TOzAPyymFpBpWmJnBAx/SuFQMNd31QNpEviuLG5rwTfpek6KPIiJ4GUOT1dC
         uSPA==
X-Gm-Message-State: APjAAAUEJDDpUHMMDb3W+H9fdH8Dumskj3JpygO+9DgBj7loBLlgTlYd
        EoIueEL5JDUEfI2RHqT04OqzwV9Hdfs=
X-Google-Smtp-Source: APXvYqz6bI5msW42zqMqJa8ChbziLHm3II8lGoaSQd+3pIZ6B3/oPn44cKmVhrQtb357WidS/Q2wLQ==
X-Received: by 2002:a63:fc01:: with SMTP id j1mr10175899pgi.220.1576382232363;
        Sat, 14 Dec 2019 19:57:12 -0800 (PST)
Received: from cakuba.netronome.com (c-73-202-202-92.hsd1.ca.comcast.net. [73.202.202.92])
        by smtp.gmail.com with ESMTPSA id y144sm17828042pfb.188.2019.12.14.19.57.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Dec 2019 19:57:12 -0800 (PST)
Date:   Sat, 14 Dec 2019 19:57:08 -0800
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Shuah Khan <shuah@kernel.org>,
        Simon Horman <simon.horman@netronome.com>,
        netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Paolo Pisati <paolo.pisati@canonical.com>
Subject: Re: [PATCH] selftests: net: tls: remove recv_rcvbuf test
Message-ID: <20191214195708.0f69a0a9@cakuba.netronome.com>
In-Reply-To: <20191213103903.29777-1-cascardo@canonical.com>
References: <20191213103903.29777-1-cascardo@canonical.com>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 Dec 2019 07:39:02 -0300, Thadeu Lima de Souza Cascardo wrote:
> This test only works when [1] is applied, which was rejected.
> 
> Basically, the errors are reported and cleared. In this particular case of
> tls sockets, following reads will block.
> 
> The test case was originally submitted with the rejected patch, but, then,
> was included as part of a different patchset, possibly by mistake.
> 
> [1] https://lore.kernel.org/netdev/20191007035323.4360-2-jakub.kicinski@netronome.com/#t
> 
> Thanks Paolo Pisati for pointing out the original patchset where this
> appeared.
> 
> Cc: Jakub Kicinski <jakub.kicinski@netronome.com>
> Fixes: 65190f77424d (selftests/tls: add a test for fragmented messages)
> Reported-by: Paolo Pisati <paolo.pisati@canonical.com>
> Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@canonical.com>

Applied to net and queued for stable, thank you!
