Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBEDBC19759
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 15:53:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2BCD206B8
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 15:53:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="JCfUKgCb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732125AbfHAPxi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 11:53:38 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:38951 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732090AbfHAPxh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 11:53:37 -0400
Received: by mail-lf1-f66.google.com with SMTP id v85so50586527lfa.6
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2019 08:53:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jOies/q8GNu6zMRJDNga96FSVWyO2X9XensDmj1AZZY=;
        b=JCfUKgCbIl3b8Om0ozKmxK3ZkAX7v5HdGpeskesaFuP4NVGJl/awlJnYAPCtEVSloc
         lzcOj6CeND6AuD80dr4q1nJBDmRFU2KqlXk9+ptF9UyEfTbMir9PajC+w3TevrMU1QoH
         5DhGRwdIMNBej8DEM2/cRH4RJvSjQ8ijfcZ6NPBCDsO/9awA61b+xRtL/izy/7RChYgz
         xTwQzNHzisQ2LYNZskcc+ZWMrodoblpe5iCPH3IT6NXa5X/R9AccGBJEJPnLdMVO54Am
         kK8utE4/RrvLlDgPlD3Taj9+1QnLV4AmRZXmPVkCyhvXdMHhxVJppbxOVcR7A9M2e9A2
         zOAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=jOies/q8GNu6zMRJDNga96FSVWyO2X9XensDmj1AZZY=;
        b=M+dzx3CzXKm9IsSjtsBq87ka9qCbXoYkhnteGsW6WLsMzxnBXWtX55vLpK+RJ3UDZM
         r4pTpya7IAiLoGSGpkeTIrZCOmtV/39vBq+ATJWsHexoJaHrLgu0r+ZsJY2zBKK+8C3O
         n8bQ9kALrBa43IzkWWDdmEKGuHxjZZTl0QTHBfVk560aCoU6FVIuFm9NbETnRiaA0QYL
         DVqZqw9IHq00cdlGKy05R/D2mBisDSOsIRaoZe8VWEWaFem0UmDfbnZB2zxLz0Y1Ou1M
         yVt4My/8/fgH2iQF4ASc7G1zArouwCVhbPKWXVwz6F9OnO/7p8u/4rox81pTmVJyPyte
         3Rlg==
X-Gm-Message-State: APjAAAUO+E6GaMCiUN9VyFVZJO0L3m/g3Q454RejnFUatb3D/33XmiuY
        zvyDB/+zBDd69iJmfeFvO3um0b9DWwU=
X-Google-Smtp-Source: APXvYqzp9NIlaxkTBvMmj+xKyDzpb+n9dCj96Ve4HvOBx6VdwDWSrusU3JCFMHB8k+qhxDs91gSPrA==
X-Received: by 2002:a19:5f46:: with SMTP id a6mr63906353lfj.142.1564674814647;
        Thu, 01 Aug 2019 08:53:34 -0700 (PDT)
Received: from wasted.cogentembedded.com ([2a00:1fa0:6ee:d28:6484:8b6b:cce6:b9f0])
        by smtp.gmail.com with ESMTPSA id q4sm16666213lje.99.2019.08.01.08.53.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Aug 2019 08:53:34 -0700 (PDT)
Subject: Re: [PATCH v2 10/11] vsock_test: skip read() in test_stream*close
 tests on a VMCI host
To:     Stefano Garzarella <sgarzare@redhat.com>, netdev@vger.kernel.org
Cc:     kvm@vger.kernel.org, Stefan Hajnoczi <stefanha@redhat.com>,
        Dexuan Cui <decui@microsoft.com>,
        virtualization@lists.linux-foundation.org,
        "David S. Miller" <davem@davemloft.net>,
        Jorgen Hansen <jhansen@vmware.com>,
        linux-kernel@vger.kernel.org
References: <20190801152541.245833-1-sgarzare@redhat.com>
 <20190801152541.245833-11-sgarzare@redhat.com>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Organization: Cogent Embedded
Message-ID: <79ffb2a6-8ed2-cce2-7704-ed872446c0fe@cogentembedded.com>
Date:   Thu, 1 Aug 2019 18:53:32 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20190801152541.245833-11-sgarzare@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-MW
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On 08/01/2019 06:25 PM, Stefano Garzarella wrote:

> When VMCI transport is used, if the guest closes a connection,
> all data is gone and EOF is returned, so we should skip the read
> of data written by the peer before closing the connection.
> 
> Reported-by: Jorgen Hansen <jhansen@vmware.com>
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> ---
>  tools/testing/vsock/vsock_test.c | 26 ++++++++++++++++++++++++--
>  1 file changed, 24 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/vsock/vsock_test.c b/tools/testing/vsock/vsock_test.c
> index cb606091489f..64adf45501ca 100644
> --- a/tools/testing/vsock/vsock_test.c
> +++ b/tools/testing/vsock/vsock_test.c
[...]
> @@ -79,16 +80,27 @@ static void test_stream_client_close_server(const struct test_opts *opts)
>  		exit(EXIT_FAILURE);
>  	}
>  
> +	local_cid = vsock_get_local_cid(fd);
> +
>  	control_expectln("CLOSED");
>  
>  	send_byte(fd, -EPIPE);
> -	recv_byte(fd, 1);
> +
> +	/* Skip the read of data wrote by the peer if we are on VMCI and

   s/wrote/written/?

> +	 * we are on the host side, because when the guest closes a
> +	 * connection, all data is gone and EOF is returned.
> +	 */
> +	if (!(opts->transport == TEST_TRANSPORT_VMCI &&
> +	    local_cid == VMADDR_CID_HOST))
> +		recv_byte(fd, 1);
> +
>  	recv_byte(fd, 0);
>  	close(fd);
>  }
[...]

MBR, Sergei
