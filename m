Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B9E9C04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 15:51:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDE9F2166E
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 15:51:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="rgoxTKFA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726631AbfE1Pv3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 11:51:29 -0400
Received: from sonic305-8.consmr.mail.bf2.yahoo.com ([74.6.133.47]:37992 "EHLO
        sonic305-8.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726371AbfE1Pv2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 11:51:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1559058687; bh=tlHxznzXAd1ti7xpaI9euhKQkuuQT0YCuRyqOSjxBao=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=rgoxTKFAol8kqHNMfJrZ17Ye5CI51TsDefiz4sMNXJKhR6bpsPN3zFCZZPwOQcRZ5kklCztQz9yEnAuuv18Z0oaSOEthmvdUtcYPLU+KrJ13aLwEuqZBws0CMtjujgxdGVmbJKfPNiyScWA+rGF1wGLxT9mJbNLCBIGvt9uIg5C0CqjXtLgR3NnvuzU04qkwZgpP8pTSGmAKQJfFUqsjJXxhcfsp/7VzYVfRexIbE2P/ofL/wPW/PLOnfIJrEvhkoZw4YbPQ7FQhMJSmH8zFTR6zSzRuvIEM5rv1i1RMOxaDGvaeJI0WPGZgVKb2JhTxNWu1KYBz72duvYcY/tpotA==
X-YMail-OSG: pI_6HCYVM1mvU7LepYgiXkB_wbP9MEkd2KHZ.uAS8C5U80iuCMyXUDAS_bedhcx
 6G5YjUiAZ4Nv7Sx_KLBKUAle4iW2AvgLY_8aGSPFXrNDIqy2iPh2L7cBzuPtfkWTPqJ86oJvhAN4
 cDSa3AaRjXqipFezxmRzdl0HVC60oXmdaEFp8Ufr3Hhddt.0ufgzKiW_Go.qKQR5P5Z_Y8hDkXy4
 qMKT0iDOS8i9XwGYBcI.f5WvO4kH099i0TGUfw2QrdJ1FvCpM5WsycA9sk2FV36wqU26SCiEmyL5
 x_oR1gfWrs8opTWEEnNJ.eYntyldiCk4GdR5mdOB_K7Z9GHg.ZDrdl8Jan2SPuY2nnmaIgWhYkov
 .95145Fm87sD4iE1xy3aocjJlN_Ae7szIuhOSaOv0rYEu67joVbF8bjgIwF5AS95JzJsrqb1Lxtw
 _VRKZVLrNx_mlAWbJCrOWf4_c5iwS4NSp8c18kO9tfpdiyYUgqR7Dmu05a8gioRp0rcvOniacFpF
 odsCQHnQ94AbCb8MtfoVazLt0j9vnDPN.QYadSrwp6PQrr2TkGoZ5j9dCccFZyiwdy2BopaGzxOm
 CAZKDQvpbOzPjQ7s5K8cepcgAj.u6WhJc6Il9.RuqQf8M4fVBG.ScqPEEuxFphu30qCDTKYW3jm3
 hCojz0ywzQqaiGyeKuVDnD_nCb5xrqhNEySZGef6zf0EqrXawKX.C56Dsxwt_Kyb9J7gWTQMfrTM
 1WV4mH4H0.oZe_K9xf3JehJmezA5AvcIuRKq1z2HXajFeNpDJ3UHn_zTx0SlwwsJFHWrEoOZzuDb
 WSlZZdRSLRED53kpy8B0GZpaW5fHnpQCQ0s8Y0GG_sltNy8A2NB4qrslx6_mxqIxAahFkWIvn6YT
 DCHSNEH7J_LqGi8bRZPLORJOcjPUB1wTTzKBe58DGH2FZP7H9Bspt7jBew.MVW4cZ_q5s3_7rNLJ
 bc_97079etCv.v5jwFk0fvm_LmzmHK4MiaBl6ifOz7O4erhiDJxDhcthBITwFVeh83yZ5Jg2sIUs
 rWAUhSY0uHk3iGelLlsv2lLuBVxSjw_TeIH0qkNif7RDchNy9dK_LMVMfO5JkiYKakO5H44g.wJ9
 zegKDko9P1Rd8IYZvUhSs6SPNe7K902UZZjovhXq1jCD1lmzbieDHLaLBuxQ6pLm.D6b5wsEAJJi
 IBTS7Fb9RkjBvRxSkqVoUTZeb2MVJY4qmdNBSdW9aFqq7sSWb6erXW0Vie.Ve_ZSBbeRDJm5UwCW
 ROHW21DqziYK9IIehJ6m6bo.w
Received: from sonic.gate.mail.ne1.yahoo.com by sonic305.consmr.mail.bf2.yahoo.com with HTTP; Tue, 28 May 2019 15:51:27 +0000
Received: from c-73-223-4-185.hsd1.ca.comcast.net (EHLO [192.168.0.103]) ([73.223.4.185])
          by smtp421.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 0756f6323010848d0e69106d54b43159;
          Tue, 28 May 2019 15:51:24 +0000 (UTC)
Subject: Re: [PATCH] Smack: Restore the smackfsdef mount option
To:     David Howells <dhowells@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>, jose.bollo@iot.bzh,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>, casey@schaufler-ca.com
References: <1ebab7e7-f7ee-b910-9cc8-5d826eee8e97@schaufler-ca.com>
 <11440.1559046181@warthog.procyon.org.uk>
From:   Casey Schaufler <casey@schaufler-ca.com>
Openpgp: preference=signencrypt
Autocrypt: addr=casey@schaufler-ca.com; keydata=
 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
 abzjfg==
Message-ID: <9191ef31-a022-cdc4-9bed-ff225e4179bb@schaufler-ca.com>
Date:   Tue, 28 May 2019 08:51:24 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <11440.1559046181@warthog.procyon.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/28/2019 5:23 AM, David Howells wrote:
> Casey Schaufler <casey@schaufler-ca.com> wrote:
>
>> The change was made in commit c3300aaf95fb4 from Al Viro.
> This should be in a "Fixes:" tag?

Thanks. I wasn't sure how to properly apply that.

>
>> +	fsparam_string("fsdef",		Opt_fsdefault),
>>  	fsparam_string("fsdefault",	Opt_fsdefault),
>>  	fsparam_string("fsfloor",	Opt_fsfloor),
>>  	fsparam_string("fshat",		Opt_fshat),
> Would it be better to delete the "fsdefault" line?

If it hadn't slipped into the 5.1 release I would
say to remove it, but now it would be a regression.

>
> Also, should all of these be prefixed with "smack"?  So:
>
>   	fsparam_string("smackfsdef",	Opt_fsdefault),
>   	fsparam_string("smackfsfloor",	Opt_fsfloor),
>   	fsparam_string("smackfshat",	Opt_fshat),=09

No. smack_fs_parameters takes care of that.

>
> David

