Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD2A8C04E84
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 16:41:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A7E42166E
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 16:41:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="Cq5788+C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727047AbfE1QlM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 12:41:12 -0400
Received: from sonic302-8.consmr.mail.bf2.yahoo.com ([74.6.135.47]:34959 "EHLO
        sonic302-8.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726362AbfE1QlM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 12:41:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1559061670; bh=ajKr6nr0/uLLqTGpOOZTJrU/GouJeyHARG94FDFyjyo=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=Cq5788+CBUn2PJspJgngQGlLRnhcQ+NjD3IYFD8tWNi6OcXfQqwOZ/60k+1Fs5D75rf5TjGZexOlg/Eqspeyf8bDILLjOL3/1cQlopIikfbOzMPC/a3EkkwKF46tkizBfvByGfLknSycIDueTKLxAbK0G8r8pgXkCXNUgLRjBb1V3xS7Ns8Vd7sC6IIar8v4NewNLYjPhMWIAUhDxxBoGPSwfyI4r8H1HagCkBzB6oBi+FYnQ9FqF5S0eK4gqfolhW/gJMLCuAMuCDCfYOzlfWWNASFHsbPhphFH66PhrkC1fLHKchf9pZHFJWktMSaoS68d1Jnb2UYonpVx9n/bdw==
X-YMail-OSG: 8yzf4B8VM1lSTT1WTKqU.2YGwIUPDIRtIpZgGyRBxWBwQ8YL4McTadIQZfjZBj7
 KRcQD8v.6VaFZ.U4yzJ3Ulm0jX7w_JQI7THx23xU2C5PpC4UyH7lDywKgewmCG7FmoVE8KHmP3qw
 OdTvpF7UOxrwu5_mT4pu3s8Tfxvt0WaxJE65a.8AkXuv2jNjuRVZ9rVgYiX_3rQZ4mYO66eA11uY
 vytbuzXejd1Ii2KURxduqUQrUB8u4cEoct07u8DCQ7CwVrqjVfu3Qgrs27kBmurSq8U5qBJpHXTw
 N9G.7IxNC3.lIJ07k1U7qwHKYlI.MV3lHaZ7grwgLYqlWCm0pggkLxYQ9ZHfkcYJdXoelNMRHTge
 gnWnDnm7ut3U6cE7OXb9.U4LPrEvXE1hmaXbD9UET0JW.4f9svRIkaS.oMDzju90BNQiFbBwYWsV
 6bUFKuUQiTC5avKmmkdcHyavIJwi78UgFAjTh9jnotY62tsv2_kRQwDYkpwGlJCfqW6t8O8H4tSU
 Q0408smeGMd6H8XbV0qoQjdDlSzjXo3_9JjiXxFXr1VOvHDlw3Rmpj9pqUAsah7EVoxfYya__CWa
 tquNEtDCjN8z3S8pFrHxxuOeq2Jv70WzEIK6_GEe6crTRzzvktZBD.9PWELLQ2HxWoN7D87kGa9A
 d1oEFj.id1.ib9EHFWXbp25A4v4FLTPolCP_vzAl4E.FwwjcDcAswflKg77iFx_OhVi8BioG3sn0
 ujo8hPRrD4x.TptGJMGSgmBi8E18oYIYzJBqe_xEYQdkgNz1hzKSf.rk3akNcZoCAT7s8myYAfrc
 DS4hKBYJ22LtNEzwngLiBOWqt8TL52C60hOwCozMPgpeLbrnoNQWNP_UZUkuhX.Q_x4FqioRwzAs
 VNBUEKP5IfzQGt.8W.sWCvwOs3twVkjgKPHKxh60BGMgUXwGeTrgCofob_qAP03KayrbnnNXZWM1
 LJFNyZ6ypxPl1S09PfEcKUgm3C4PtyK.I13ScmN2iKnYMjlizE4vBhmsQehvPN3I_7H38ZYxuq3G
 WTl2qb6zB3zYZBGTfd4p6wvkTw84VkKCJG2W2Uvu67AZWTnPKQfGVk06VtsSCLjpWxorNpv2DaMJ
 c47vAh2u3TsfzJavXe0vKsPKX4oInH7xpH6GNGVlbZJhffHl9H0WPK1Qdh35G4jXx97tGM1_cWBW
 cSM815q5UufQxrEin3Jlt47bnVX_uU7O97VS1YvsgLKzhGiBKDC_kP70kTnmWbCUYEjaBKDTxd_t
 sAVCfuMJaRB9zzh307IiVuunX17GsbHsGlQ--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic302.consmr.mail.bf2.yahoo.com with HTTP; Tue, 28 May 2019 16:41:10 +0000
Received: from c-73-223-4-185.hsd1.ca.comcast.net (EHLO [192.168.0.103]) ([73.223.4.185])
          by smtp423.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID d423e2f5b6f809050d4d6eccdb67e317;
          Tue, 28 May 2019 16:41:09 +0000 (UTC)
Subject: Re: [PATCH] Smack: Restore the smackfsdef mount option
To:     David Howells <dhowells@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>, jose.bollo@iot.bzh,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>, casey@schaufler-ca.com
References: <9191ef31-a022-cdc4-9bed-ff225e4179bb@schaufler-ca.com>
 <1ebab7e7-f7ee-b910-9cc8-5d826eee8e97@schaufler-ca.com>
 <11440.1559046181@warthog.procyon.org.uk>
 <9330.1559060541@warthog.procyon.org.uk>
From:   Casey Schaufler <casey@schaufler-ca.com>
Openpgp: preference=signencrypt
Autocrypt: addr=casey@schaufler-ca.com; keydata=
 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
 abzjfg==
Message-ID: <43e3de52-13d7-8089-11cf-a384662401aa@schaufler-ca.com>
Date:   Tue, 28 May 2019 09:41:10 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <9330.1559060541@warthog.procyon.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/28/2019 9:22 AM, David Howells wrote:
> Casey Schaufler <casey@schaufler-ca.com> wrote:
>
>>> Also, should all of these be prefixed with "smack"?  So:
>>>
>>>   	fsparam_string("smackfsdef",	Opt_fsdefault),
>>>   	fsparam_string("smackfsfloor",	Opt_fsfloor),
>>>   	fsparam_string("smackfshat",	Opt_fshat),=09
>> No. smack_fs_parameters takes care of that.
> It does?  *Blink*.

Well, something does. I can't say that I 100% understand all
of how the new mount code handles the mount options. Y'all made
sweeping changes, and the code works the way it used to except
for the awkward change from smackfsdef to smackfsdefault. It
took no small amount of head scratching and experimentation to
convince myself that the fix I proposed was correct.

>
> smack_fs_parameters.name is just for decorating messages, if that's wha=
t
> you're looking at.
>
> David

