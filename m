Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1804C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 13:54:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79BC720882
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 13:54:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="IvuiMpyV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732187AbfDBNyt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 09:54:49 -0400
Received: from mout.web.de ([212.227.15.14]:52035 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732085AbfDBNys (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 09:54:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1554213270;
        bh=k91NcjSyQqyCkKw4wGSO1ezkxgl3DCEboDfJN3NWxqw=;
        h=X-UI-Sender-Class:Cc:References:Subject:To:From:Date:In-Reply-To;
        b=IvuiMpyVVtxvUjUHQjj3TPqnIwLiSiKAG6qVD9rkrPC7Qmftgp507sry/RV5ck25X
         FYbMGE/pzK7Xk53cEeS73C2S1vbMHbvemVQ+B90roubAEnVgicy2PruZAuvM/iuibH
         PO2erwCanGwtkJNTstzXFJYV62GnN8C+VtAwCqY4=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([2.243.142.30]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MRD0p-1hMUJ705Dr-00UWfL; Tue, 02
 Apr 2019 15:54:30 +0200
Cc:     Andrew Lunn <andrew@lunn.ch>, Jason Cooper <jason@lakedaemon.net>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Yi Wang <wang.yi59@zte.com.cn>
References: <1554082674-2049-2-git-send-email-wen.yang99@zte.com.cn>
Subject: Re: [1/7] cpufreq: ap806: Checking implementation of
 armada_8k_cpufreq_init()
To:     Wen Yang <wen.yang99@zte.com.cn>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        kernel-janitors@vger.kernel.org
From:   Markus Elfring <Markus.Elfring@web.de>
Openpgp: preference=signencrypt
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <bc7c03e2-798f-7ccc-4386-227a9e16611d@web.de>
Date:   Tue, 2 Apr 2019 15:54:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1554082674-2049-2-git-send-email-wen.yang99@zte.com.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:T3gwzymDCjepm7QX44vfGpX9jdksg2LRB0TBbeLPbppaxn9utCy
 eknkPg9Vq4hUOYdIRFKjMjSkikCvn7X+rVhrJorGZoIohnQqGOCP/qvj2jTKqfdUCcIs4LQ
 CwqIkb0KgvcUlM76jkSF+0LREC6vv/9k0ZZkL/o1mk7h0qfgyP2GjNyk/DBk69yda9hZ3T4
 RNN+d8S3zbsUetC2h8deg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:x2l8f2bjtDY=:HIIrz+adUUy2Qk+npQckQR
 FbrMnTzGuhehu33m4k/NsnWWSWwuMIpz4ulUo4dbtMFORK0xZUwE0uXJjt4OdI1OjTraA5Nsl
 GOrHbAcQKoE70DOs2UmKhidB/OwY6jz7gJSbsHUlJaF0RxeDPdUK9iq+70h2ZXX8xx1z5l1ag
 KnwFa/BIagA31zYUTcPAJLn0Y2pPEZc1dBhju4xvUgy8Qw2VUSFQ9uBzONSRHgY/rOstFIty0
 zyg8PNXD80muPv+KJmDwly0aAwJx//lb3jJabfEuabgul0QX7qmjWEUM5qzm/FwynkNrQFBVz
 9tGcMUBivvyI4qh+GyZIHbm5gd5noj4znMHrrN/hDRwP/6rwGSRHv6US9pqb6bWW/NjwillIR
 XAe4G3FZgWS1E8pZTjmXJRf30WIdffhWMiKdPFyBTxMKL2/WOPTvoTBvscFJLTC1RXPSt15+f
 W5HodEwSXOPlrlm4My2UQ7yZUVxPZQE9/oAsbwiTt+Qa9ZqMWspnRIJjpJptyNp6LOpnN179m
 d0dE5+mzgk/PeyJv5RF5GArnNha9+xTjnpsHSYtpo1Kmui+A2RDJiW9XLzKpySFyS69Jtu+EX
 kM3X2MLlGM5u4ySpB/WLHNFubL97IoI4ZOfKBSdeplIsNC/QFwnlTVNmazcoXdK7tuwT8Cpi+
 Gg+AjUWjXNa8v2XFerrDITk8+ngGd1XKzeR2dVpm1rBLC0CgFXUHd9JBt9+hYCzG7ZNG5JxYO
 WZahTP60V2eR5RbBsBfIjYK/uqmB7/pGdtAvBPXhXOh+mc1jFhjTGDtpjFJ5+NC+uNqW9KpKj
 fwd++KgA2tg/Bp7AZS2Czmaq+HlAfSTQ9L0FyQ7ERMIMA5N1gTmgbRd0At60W9j1UWqZMZaLb
 /xrdYHBsPodDSamEId2dZm4aUJ8aM48LT7BvgW4QKwao/B2sDLftNhoEe6ekHhpHt9M3Z9J25
 aqp37CoHWlA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> @@ -132,6 +132,7 @@ static int __init armada_8k_cpufreq_init(void)
>  		of_node_put(node);
>  		return -ENODEV;
>  	}
> +	of_node_put(node);
>
>  	nb_cpus =3D num_possible_cpus();
>  	freq_tables =3D kcalloc(nb_cpus, sizeof(*freq_tables), GFP_KERNEL);

Would another null pointer check be safer for this memory allocation?
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/d=
rivers/cpufreq/armada-8k-cpufreq.c?id=3D05d08e2995cbe6efdb993482ee0d38a770=
40861a#n137

Regards,
Markus
