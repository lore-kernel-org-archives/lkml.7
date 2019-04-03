Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AC39C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 13:51:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2502520700
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 13:51:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="LEgepbDx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726524AbfDCNu6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 09:50:58 -0400
Received: from mout.web.de ([212.227.17.12]:39579 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726184AbfDCNu6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 09:50:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1554299447;
        bh=blNJkLtbIxXyKtESHLpfhiBg+BN6ZAL7fXxJ3diBMps=;
        h=X-UI-Sender-Class:Cc:References:Subject:To:From:Date:In-Reply-To;
        b=LEgepbDx7HZvUifWCUeNS9+WyNFbBltQABaDFeMSWltt8V9PpzbzvciRt/Up5D+cp
         PpEl/TUEpnbEjCAwIbdWCref+QTcxW3/GjFIei010fQekQgOex6+yyf4L26wLdyQSx
         bsMmofhcnOR0wdzGnvi3vwUhxSPw3bPzrYgXTHN4=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.135.115.60]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LsQTc-1gnN6N1NN2-0122CD; Wed, 03
 Apr 2019 15:50:47 +0200
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Yi Wang <wang.yi59@zte.com.cn>
References: <1554082674-2049-5-git-send-email-wen.yang99@zte.com.cn>
Subject: Re: [4/7] cpufreq: maple: Checking implementation of
 maple_cpufreq_init()
To:     Wen Yang <wen.yang99@zte.com.cn>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        kernel-janitors@vger.kernel.org
From:   Markus Elfring <Markus.Elfring@web.de>
Openpgp: preference=signencrypt
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <5d0e8f12-baaa-e4af-f1d2-03e0508e3fd1@web.de>
Date:   Wed, 3 Apr 2019 15:50:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1554082674-2049-5-git-send-email-wen.yang99@zte.com.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:nJsBKbKw0ePQTxlrVjxENTz4ada8ObIR4h7eopZWr7LAbtQIhIN
 dX1zLRGaFh0NKRf5sDvwbpbKVxtN4h/VLP1enLMMuVtdg1D7VuMq6ltoP6+4P9g2i+FCjvm
 n3L4rjoIRaYd/zyunMRlQZJ7ZDxUpz8dVvvqFTDV1fvheMYSihYoXc7RnEHdO/1SMp5CPKW
 OXBhKdShME9l6O+klvnjg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Vux/BMXRm1c=:g5+wV7JWFsvEdmbsPm1uOE
 QQvEl067b9FC4fPqWI9cgTUNyo5x5rkQU4Dh67VGGFZC8T+3FT5tdFrt/RHrq5GjLRhjoiRjw
 d6Fp0oawBvXPmEQM3tMpqcxDFAs5m/ryFqzfnOGqnaAoHgoYMvl59LdVEfNyMUvmJ6yPxA3SE
 uHZz9OkPF4RW06W47lz2gSnvFyFWJexwSuSqKhyNBQEVSPdHfC0uoc+VhYNNVYrvpAA4ovryw
 jSRk9JtgzCIUspMMoJ8QaCf4gutJaQJKbu2aIL1XH8MTkf5sNcWEAyz/a+wj4xyR/qXbk3d+y
 uScX4pBLNEr4OvnUFkBGuBqYcNro3XEclxCP7q5gWKRMg2z+FeXZkRWOE/dwAkOJlPLwhXYx7
 5INF3UevrZ1veT5JmmvGDseCfly+sc8sQ7LneT97vwUkV51f9W4wxQ4BZzzYQpP+IjAKGRJ22
 4u25rFIZLgenl+4brTszckCx8cGzvcYqsx63aEJv51LAFkKm+2Nu7yj650JSLS0gZ4/6X4wZD
 bPi7qtiFR+KorDSdAho/XDDuBQWXR/Rf/zg05I4fBtPijedU6+w+oXiKU+25aS/9bBmZ68Fpt
 AOkYwPAmuarzZ79uUXVDyrXjjGFrfzHcE4n24oXXisB0kUA9gnJtJ0WE8AYjGE8UgpkpqUcBV
 XhuooLlqkY3s1mE3E6ENf0X+3R1Z6L1MC4haO6SvbzRmboymJZq8Ul/ri4n+WKJ4/bYjqPq89
 YiYC4e7qehuY9gQ9wdsURRPTdjOguP3hTeERN5x18uTBhRiLKPFRUksfvk9neBem3JtJBcPoq
 WCCFeBeRSRK1Frwh4KcWTkz1czGo0uSnvlMOy1jih9d1QMNIfH1StnZNbQCQf1Vi+GPDQ1cJA
 gwpVGggcWoiTdLKYlL8MjokYgqaJvpVDk5FvVexAJM8xiwDg68DWSxbnvFBFGejfpsOB527WQ
 kV3Jeglu1DQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> @@ -210,7 +210,7 @@  static int __init maple_cpufreq_init(void)
>  	 */
>  	valp =3D of_get_property(cpunode, "clock-frequency", NULL);
>  	if (!valp)
> -		return -ENODEV;
> +		goto bail_noprops;
>  	max_freq =3D (*valp)/1000;
>  	maple_cpu_freqs[0].frequency =3D max_freq;
>  	maple_cpu_freqs[1].frequency =3D max_freq/2;

* How do you think about use the jump label =E2=80=9Cput_node=E2=80=9D ins=
tead?

* Would you like to reduce a bit of duplicate source code at the end
  of this function?
  https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree=
/drivers/cpufreq/maple-cpufreq.c?id=3Dbf97b82f37c6d90e16de001d0659644c57fa=
490d#n232

Regards,
Markus
