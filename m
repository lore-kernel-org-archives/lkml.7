Return-Path: <SRS0=k4ck=W3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73C9CC3A59F
	for <linux-kernel@archiver.kernel.org>; Sat, 31 Aug 2019 11:25:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 311162190F
	for <linux-kernel@archiver.kernel.org>; Sat, 31 Aug 2019 11:25:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="H8iNqYzI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726740AbfHaLZt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 31 Aug 2019 07:25:49 -0400
Received: from mout.web.de ([212.227.15.4]:59943 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726282AbfHaLZs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Aug 2019 07:25:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1567250732;
        bh=DlSYT66OBGSnfP54hw5m6cMRc+3G9rfSB8IiycTzpMQ=;
        h=X-UI-Sender-Class:To:Cc:References:Subject:From:Date:In-Reply-To;
        b=H8iNqYzIuwc760ymC/Vv6zX3wB99+7grkSCMQP+3aLK2q1/d4jABGD4KyHTLaLIVo
         cK0nu7ELj7BWVoRDbb2Bs44rSEAhGd3WOAaStEgoVBeBJCvdjedgMSCLszJAP1vivi
         cynexVHOKK4FKmYQeS5crSCEliVwBFoPpj5sVsAE=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.132.129.60]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0Ma2V5-1hkygd0s1v-00Ljuw; Sat, 31
 Aug 2019 13:25:32 +0200
To:     Denis Efremov <efremov@linux.com>, linux-wimax@intel.com
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Inaky Perez-Gonzalez <inaky.perez-gonzalez@intel.com>,
        Joe Perches <joe@perches.com>, linux-kernel@vger.kernel.org
References: <20190829165025.15750-6-efremov@linux.com>
Subject: Re: [PATCH v3 06/11] wimax/i2400m: remove unlikely() from WARN*()
 condition
From:   Markus Elfring <Markus.Elfring@web.de>
Message-ID: <c9d3f0e1-d2c9-aedb-385c-82a8cb077253@web.de>
Date:   Sat, 31 Aug 2019 13:25:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.0
MIME-Version: 1.0
In-Reply-To: <20190829165025.15750-6-efremov@linux.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:QikbVll1VSeuPMm1xi10fGh/8TTCw2yPksGd3fU1U0S/eSTxa96
 0zR9QBW2ww+898hsKNDtv+adh0hArdS0l8JbzY5CCcWmNfSV7PzWGglw7QXjkD/jybdkDSO
 NIeqXeEBwWO9oR6z0v5fzqtrSHhhsK1amlPRsstbtolBLcv7P4qo3vZ25G037RssO9YK/6m
 eytLBKRQkGFTVb4vOe7Tw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Tf2oas2EQHg=:cy2tXNcN7R4SGquETxN1fK
 NzoDBVf9SkAVK8KeQ/EMCO2RHfHfZdLx3tXGxGO6zs0G+4HhRJVyXYS9lCuzUgSDW30AdhAMr
 EzGO53I+qyMgs9szpcmsedQrLjWmvft5g8EvaouMZZoA1y63ShwlErkJMuq/fFYZ8EJo+8SCx
 2yi1bCrHgpREsPwBECXfpLBYzux8jdWjZei8dZOF7gFNY94wYi/iMQKNEdveIokInSEev5YYA
 amvVx/+/FTIatfhTzM+a9IQCsTicc2VwDQS6sv7gdi1ZaL22lVFNFw0v3SrQTBfLgZhUjG1Hf
 1+4Xb4R7HvokRh51EjeyrCEQM7Qt5sEy4xlZ7N0RVfleq+mroBhnaiOukLFxKYi93wloTzbvU
 hK4c6b/hXwPQEp7CK5pcblpJpTbg9blL3ASc/rXcNQcFFt+ayhgGiJffX/XQxDSMR1r0mMwot
 3WoqUsOJgwqiryqYYaowdM/rqZf2NruRGPi8WlESaMnyR8vO7PDdiQLkWHQew7YHh6MM1hnEQ
 acOtmqnqm2D9NnKu5FQ8SxTKy5/ieKW4gOiv/ArkUcQlA69HC8GV2b7AnGYykVIXh1IV1+Nca
 Me1wjI7GoQ0O2ozUnldNHW285577Jtk9Qj1QaAFbvEnLpiaJhRkQXpCx0i2RI2ehqIOklw8P7
 TdNmUOWyH1NT4H2I7cBH9+51IfU8FjLJP4LtFYQPeLXrrJraPNl/mpbCC3ZvW3bcUk/yNXcNp
 R/J0YtTMjWdK5KNuzFrsGxWvgPfufSB9n11fvtU5xCviTMfeddp5m7yZ9HhuvDjtYEOdb7KUQ
 uvdirpQNcPJoWNd1tmIKl7/ZcHuHYrT6e0JOhAVxQRiAZ1zUXJ70q0OiJ8unmk776qBsaa8e+
 wlVZO2/7cxrICHI7DzkYg+tcwMsZ6oXTmgP+KpE8uuszlxhPsVFWyA4sBhH+psMKuL/s80zhd
 G1ulWKQufELf+QV2vhyCk9POqQiHpqYJKrhf5ck4Szs6l1xQdLvqmpslgO5VXNkE4MqMoGaCS
 oy3RcLGdJ+6m9uirkX3d0HKLdWXV/yy4XohvQnvDZIKsfbJM2opNco6fmfPhoHf9lRCb444nT
 AJeNicHhEwJIhXnpfq1dY18HNzPMrwhnM2NWT2V2qqvEDB8x3VMKxkKhIfLcA89l+FiDEgwnv
 aMleK4ussKuBffwrw653jS3zWF9YJoFmWvZpS1+aTu7f+9tg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>  		pad_buf = i2400m_tx_fifo_push(i2400m, padding, 0, 0);
> -		if (unlikely(WARN_ON(pad_buf == NULL
> -				     || pad_buf == TAIL_FULL))) {
> +		if (WARN_ON(pad_buf == NULL || pad_buf == TAIL_FULL)) {

How do you think about to use the following code variant?

+		if (WARN_ON(!pad_buf || pad_buf == TAIL_FULL)) {


Regards,
Markus
