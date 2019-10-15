Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21A97C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 17:55:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7BD52067B
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 17:55:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="IL40Azom"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388893AbfJORzj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 13:55:39 -0400
Received: from mout.web.de ([212.227.15.14]:44223 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731694AbfJORzg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 13:55:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1571162121;
        bh=TZIhK7EPJZ3JVj0kpDPDNCPLGn4fJ8OQ0rsR71wX43g=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=IL40AzomKPZnMDzdF2ZsIESiMuOZ2yOfmKNRD78hQk37bqCJqCJIwPPWkYSr3Vsc6
         xv/ns6b0TCLYgZLxQCzRHzcLUxVFk7M0S6wZnvIb38vXAl9BnItPkl24Erw8j8wlqo
         21o2aVH4NGZ4p22ua8lHnLQWhKqTi7lcmVFLD5Eg=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.132.79.11]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0M7bVP-1i65p0023L-00xKuS; Tue, 15
 Oct 2019 19:55:21 +0200
Subject: Re: clk: samsung: Checking a kmemdup() call in
 _samsung_clk_register_pll()
To:     Tomasz Figa <tomasz.figa@gmail.com>, linux-clk@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org, kernel-janitors@vger.kernel.org
Cc:     Chanwoo Choi <cw00.choi@samsung.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Aditya Pakki <pakki001@umn.edu>, Kangjie Lu <kjlu@umn.edu>,
        Navid Emamdoost <emamd001@umn.edu>,
        Stephen McCamant <smccaman@umn.edu>,
        LKML <linux-kernel@vger.kernel.org>
References: <7933ce8f-ca1b-6ed8-14b9-59679130dc47@web.de>
 <CA+Ln22GpcMF5e8wjwoRH0wExyoGfta4n3YuaOBNDE+rfqhSZjg@mail.gmail.com>
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <39a142ae-e0a1-0683-d68c-128b388f480e@web.de>
Date:   Tue, 15 Oct 2019 19:55:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <CA+Ln22GpcMF5e8wjwoRH0wExyoGfta4n3YuaOBNDE+rfqhSZjg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Provags-ID: V03:K1:vadA7w8m5et9Kx41H25zGHRg87E2nONtqAmT24ocOvYR+/eR7T0
 VMPqm5RUNgyq33b4RjrGIEBwZAFmm6bbhFD9qNQBPfk723JYDya+BMR3FL5RdTuGA7ilppy
 6UFGsC/yeZjqwv7SY85tIGJG5HfxRMzw9iyn+BLJzHn236tyO5ZKMdBaksDa0Cv0VBE2kUC
 a3RPcid4HumSc6v5ZR6rQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:4kQck1rPbFM=:htyPbTF0j7kl8J+L+lMiO3
 qt/aTYR1DvNtX+KzXL8WKylAgGco7HQwFzSmuncX4vCLC3Hx7QiR9gyipEw7yXCeWeDMCJ0bj
 mzC7GeJDvKvkP9P8b3x0DRf3ggsMJlP6NMB1Q835ZjLtbporFTsp9T5q3vpV89W2mPArr8hWi
 CBBS17LLsljzyn+4X2vOx3dLH/A25OH2oGBmnAqIvb+UVRgT5Dra5hzVqdHO+QN/vk1Q9a5va
 3qicr6/JVOhH/1DsNIsr+UOLB1GxK4cDrmHY2t+PBOMetFWzhniHnDIzIUzu+W3IucL4YUZam
 8hwi42xQTcfz19U97RIupnMSYdtqyJLCxp5YjpqjWGy31XebbnudKiSf1FnGYafFnrI4y5oXG
 Fns+MP+6verfm5LtHO0LVY9o0WwczNgeAAU3HUq27G2GUX9puXLbfBeQ28oFl0cYURarYGd3j
 LQF0fcNFhq3L/40sjgn+3qODUt5nOMc+taBED9tiFU1CK/zcGcg/ORZhh4T5qt+9a5EsfSawC
 aIXkqF1ZR9CCSA5ZTuf+at8q7RM8wVBKAiaSOz6Pn984rSyxyd1BGmXNJKdMgUa7WaJW+fsrT
 9+zUa2eEdF3rwUDqI7wnTbOjD35N4um9F9QcX3hLubMIq1RCSzQY0+gaW4EbC0c4z8SogVtvh
 qO4n8A+h//m88D9ND+mjjM97FYn8EXPjxa8EGMOnRlcMeogKqOwx0ANWtA85L7R14mbroe7zP
 KcL/BctqRT7W1PDDyhx4zX0CK8qjRhZPQaExoZ1S8LLEo4snem1K2KFj5ATR9fTgIoWc5gXfv
 gd8wdnpUOBGVj6HHHXTxj3ZfcZ7MrT7JZMVTX3fafYS1coWahkr3Mq0vIsYbJ6XTSsOpb8JtP
 bfSIQegqjl0PUgfQp/Id6xX5ZA7QVAaSpOF1MlnJrd5Q1hQVXk5OWhonZZfHj/+rbAXat//7j
 8pfe0/wk7Ka0TGRE+qT8duVMLWItTCF3LspkLIeojKvFxL5Z9PJLXBhUkcmmM2pWyK47G0yUJ
 7jR9V/EDrvrdKstvLzTTlZEqE5LDuBsT0LQ6K165zjCKQOwHmyow6dIaP8tX37Jx9pVubfQHh
 zFd+VcpvYi8yqqty7bKN/Od8jEqdFlRUl8JweYJfI5//zN0XtQ1mc6BjtdMqn4aNp/uUNs5nt
 P/4bXt8uAz2UuTq0X1aYl2yUm67FRyxDxBlDx3WMBnda1mbmyOnGrFK7eNtqQyAQdCSC7fxtT
 htMbaG8h5rPe3tzVin41PuPNoNBk0nM1pKjbUYBB4PH5RmlRwNNKxXCrvYTY=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> That said, there is no need to print any warnings or error messages on
> allocation failure, so technically they could be removed.

Do you find information sufficient from the Linux allocation failure report?

Regards,
Markus
