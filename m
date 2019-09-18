Return-Path: <SRS0=HfRD=XN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA8D3C4CEC9
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 20:46:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88AA5207FC
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 20:46:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=pensando.io header.i=@pensando.io header.b="vy/XpBtV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731746AbfIRUqi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 16:46:38 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:37612 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727165AbfIRUqi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 16:46:38 -0400
Received: by mail-pf1-f195.google.com with SMTP id y5so765543pfo.4
        for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2019 13:46:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pensando.io; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=WcFSQhyzT5+TpPTmaqxANm1q7R7Sdxzaz+lcQw14DuE=;
        b=vy/XpBtVnFVt9dNjuf3Z8i9pWr4rAANU7kvTq3YIkVlcSy3BB7KDLrfKUFNdDifbUW
         MbGhoxUnfP2DvynYXc8nTDQTsJvGci3pbvNKICSJ3H2wJNkI27Ck/0+hvFbS3THB7D6R
         5oh+jCv9LYUcqZ1u9KU94yJzAu0bjepw5n6ICLZ/ASZ6KYubluw4rS3KRpTWyJeKmF0B
         rUtVGBI+TmNHX7R8qBLG3jT11e+lytIR6xUmuiCFtl9rfOuuGwwLSq5cUIpfyKebPJHQ
         Abhir+NOa+WSQtBWz6DBxhGyRKz+Gu9+3Ts0RAdfSGnY96gOn+tPPEf1VRFayd9kb4yO
         8+cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=WcFSQhyzT5+TpPTmaqxANm1q7R7Sdxzaz+lcQw14DuE=;
        b=XN/6vxoQ3OvBVavS5ashC3s4DCFE93saVpXM9U4D/HjtG4pKeuaqqMqomwebSa2xP2
         yD+Sb1BQ6WaF5kszwOjen78WvrUn4ZlnbEJljB3htjgVpIgQwVVxmw+OF1y06ambu5jY
         YHzXD8tve5aqARkDNupaLEcQCYlQMsN689jcZjzXVCQSyibvbhwjLGeAjkucoOXxFdOS
         eCI6g77CZcF1ToUq4UXFUhxT7+V1wWBgOK8W+XKHLD/QKOGqw+HV5qHtyRVvak76gZsg
         7J0lOoTLfo4cClLeI/R+pJKSLX3HH7LnHyAT61MyUH/hFKalW5s783dJ1/hCx90GwZCh
         ijIQ==
X-Gm-Message-State: APjAAAUttOereoVMahacZVU4Vxo9V0o64dk/Kg9C4D9CI+WrIOPw7Ji/
        05tsiokdiWqwo+xutDOXI7aFzQ==
X-Google-Smtp-Source: APXvYqwBbnAdmulUv+EnLgF6a+92aHRslz+sZEZ5FZPeHdhG6J6tgDfsN/VyIdDue6tbbZlvPme4fQ==
X-Received: by 2002:a62:3893:: with SMTP id f141mr6099018pfa.221.1568839597633;
        Wed, 18 Sep 2019 13:46:37 -0700 (PDT)
Received: from Shannons-MacBook-Pro.local ([12.1.37.26])
        by smtp.gmail.com with ESMTPSA id z23sm5605135pgi.78.2019.09.18.13.46.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Sep 2019 13:46:36 -0700 (PDT)
Subject: Re: [PATCH] ionic: remove useless return code
To:     Arnd Bergmann <arnd@arndb.de>,
        Pensando Drivers <drivers@pensando.io>,
        "David S. Miller" <davem@davemloft.net>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
References: <20190918195745.2158829-1-arnd@arndb.de>
From:   Shannon Nelson <snelson@pensando.io>
Message-ID: <6cdb1e21-44d9-bba9-1931-78f7109bff2b@pensando.io>
Date:   Wed, 18 Sep 2019 13:46:34 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20190918195745.2158829-1-arnd@arndb.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/18/19 12:57 PM, Arnd Bergmann wrote:
> The debugfs function was apparently changed from returning an error code
> to a void return, but the return code left in place, causing a warning
> from clang:
>
> drivers/net/ethernet/pensando/ionic/ionic_debugfs.c:60:37: error: expression result unused [-Werror,-Wunused-value]
>                              ionic, &identity_fops) ? 0 : -EOPNOTSUPP;
>                                                           ^~~~~~~~~~~
>
> Fixes: fbfb8031533c ("ionic: Add hardware init and device commands")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>   drivers/net/ethernet/pensando/ionic/ionic_debugfs.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/net/ethernet/pensando/ionic/ionic_debugfs.c b/drivers/net/ethernet/pensando/ionic/ionic_debugfs.c
> index 7afc4a365b75..bc03cecf80cc 100644
> --- a/drivers/net/ethernet/pensando/ionic/ionic_debugfs.c
> +++ b/drivers/net/ethernet/pensando/ionic/ionic_debugfs.c
> @@ -57,7 +57,7 @@ DEFINE_SHOW_ATTRIBUTE(identity);
>   void ionic_debugfs_add_ident(struct ionic *ionic)
>   {
>   	debugfs_create_file("identity", 0400, ionic->dentry,
> -			    ionic, &identity_fops) ? 0 : -EOPNOTSUPP;
> +			    ionic, &identity_fops);
>   }
>   
>   void ionic_debugfs_add_sizes(struct ionic *ionic)

This has just recently been addressed by Nathan Chancellor 
<natechancellor@gmail.com>

Either way,

Acked-by: Shannon Nelson <snelson@pensando.io>

sln

