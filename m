Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0A67C04AA7
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 05:36:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 699762084A
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 05:36:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="WBfk7NbJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726347AbfEOFgW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 01:36:22 -0400
Received: from mout.web.de ([217.72.192.78]:39621 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726157AbfEOFgV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 01:36:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1557898560;
        bh=Z4DR1Mq0Ic5HrWJl84ZeqasozIKH4kMANKHCM3bItJM=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=WBfk7NbJ/mlqfE02LEBqmVOCeNjQk7yhnbUboVJEYcikflHq2r9vV31ZyuTj4sEG0
         wBOaSRq046wPbOPsSxxPlPGF/Be9WHi83Og61iY9Czkld6Whln03j/UgX/+B3lX0OW
         eqPIkcVCo1+UPt6hxcSXQTRdRD8gZf724HgfX1Oo=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.3] ([2.244.73.153]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0M8zFx-1hYAyz2CbN-00CP6v; Wed, 15
 May 2019 07:36:00 +0200
Subject: Re: [2/3] Coccinelle: pci_free_consistent: Reduce a bit of duplicate
 SmPL code
To:     Julia Lawall <julia.lawall@lip6.fr>
Cc:     Gilles Muller <Gilles.Muller@lip6.fr>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Wen Yang <wen.yang99@zte.com.cn>,
        Coccinelle <cocci@systeme.lip6.fr>,
        LKML <linux-kernel@vger.kernel.org>,
        Yi Wang <wang.yi59@zte.com.cn>
References: <e30b9777-6440-b041-9df9-f1a27ce06c6c@web.de>
 <112fa697-3073-1a95-eb5b-fa62ad9607fb@web.de>
 <alpine.DEB.2.21.1905142146560.2612@hadrien>
From:   Markus Elfring <Markus.Elfring@web.de>
Openpgp: preference=signencrypt
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <20b242a6-23a8-9b48-5cfe-c99df809dd24@web.de>
Date:   Wed, 15 May 2019 07:35:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1905142146560.2612@hadrien>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:FnYpLmoQnMZaFbDB+dxwrcvL0ZEHjOyCiuxcGYPq8ly1Ii9T73g
 /mP4AxREwfOvg6Xf0B7qlDV3RjtEY215F0nSf1Dc8x+29OYtgoVRUKAuunVfrgQsMDFKucy
 a2rwXIZtV5Ptb2NxJ8whQEyL5WqRAJ0ALWA6Yiv3dU/bY2+MfAqNdbff8QzEOUNgxGFz3cw
 pjMvokpuiqOD9l1Gu/gvw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:lNuS7+/RX0Q=:m/aAP3OV0HDxzgI5HcofN4
 hT0Di2m+bblV9cwJSM8HFQpEEZiSRNUeRX3Ciej+bEaH2hgF/omqQulCcJaX2p1MJWLR+IJ8b
 XEIHwIbyEH1onC5JilhLVthLnp9Ne21MULxYQ85rJBcYalfx4OE5lw+48suu9MfR8mSonID+H
 cGQN8DkzneiuF5Vdg/DEVASrgf0nN6nrmFm4h5OYNQCn18E7GcCSq5hJacxWfk16NrjnRAk2O
 hrb1ZVlXMeMmloqrGMLmy2t29/k68wWuoSXBcsLE4E+1Dg2dKhIToHzm855ivGFeby80eD9Xl
 kuyo9ldq6EgxymfMaVBgAh0kwjCUAb6uCf38k/gNLcpp9cddrySHIiaPhzcDLvP02kGIfqDWg
 qBEh1rqxvjmZRTdD5fiZ2THxgckt4E3B7BYoaw3GdMa0MhCCY1nEa7cl3ROerDaKCpMTYGY69
 OMNKfcNhQJ/90RGYIPyRugMbMV872ER//sA+ekORkrZNKQAJUDO5/xL4nIrgXIemxGwqagzJP
 dfK42CmP1o9J269gGGb57hfV1lWTcJl5D2InBSP79XmycEbSlTXSq622SFIDcIVvz+FvB5+Qi
 UO+YadwRSOHHhtd7mAa0DJv2NZ7TlTbhcEFG919feH5khIAGirPmy+U5E73i+MmSazYsrCucI
 8kYJsprFQk1iu+J5iMpNWLSINB0tvu9f2mgPVCzbgZ1MPcfosCQs2DPOEh43znKSULwLjRr4/
 bwPeyb24GSjKiuYgZxqSun+0hUXVVb8SSxEbj06Vx0NWTNPP2/VqhYAm8PGlNQ6JIsqzhoFEt
 5gknXdaGPi1dFv70TALlev0SEYkTaVe4bmIyY1PlURLQD69gcrHgTv2ruAVnQN2B5cDw5RqGm
 On3qQp287235QByyh/JxTYUcqTuUh1cV1gfyZ4K7pKU+XEHbt7O7Z1BN5QXz1V+BIQwvzvv1c
 TXC9PeUvzrg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> A return statement was specified with a known value for three branches
>> of a SmPL disjunction.
>> Reduce duplicate SmPL code there by using another disjunction for
>> these return values.
=E2=80=A6
> NACK.  The goak is not to squeeze the most information into the fewest
> number of characters.

Can you accept any other formatting for the adjusted SmPL code?


> The rule was fine as it was.

Can different run time characteristics become relevant here?

Regards,
Markus
