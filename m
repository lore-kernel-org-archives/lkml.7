Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 391D5C3A5A7
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 20:56:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DF7E2339E
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 20:56:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="t88U9RV2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727175AbfICU4p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 16:56:45 -0400
Received: from sonic311-30.consmr.mail.ne1.yahoo.com ([66.163.188.211]:33077
        "EHLO sonic311-30.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726649AbfICU4p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 16:56:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1567544202; bh=i5/1Kidhfx8yCcDqTfoKbAVXtBe1GNrO4nCYULPd0K0=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=t88U9RV2oiRtLX6FDFktteMZwEmbRCJv0g4UDRbxxcX8MczzYXBdEDRh3UlKosVNQSNcVpA2fINoWxswyK8MVLzFbGAlv4YHqV/+magIAk/xWVeJyAE8lVO+qeVlxYTtVGmeEQ9L4A74N8dP5HQqnjwYdWDZNBVqYaEVbh/TbwAw6l7FlKLdSmAHgaA4jZZ82vaSRez9w2PuuJuj5EFic7M3fUtYKuL8ByAGVZEy/VWhe+9eT7fGXFliXIwa7jLvTL7xqC3eMlihR4IvSrWshKSvFOkYQifkxnElicCnIib02KC0fwGTR8NRrO0FZ0cmMeT+IxnF355X+b4jlXVYCA==
X-YMail-OSG: vDDqrJYVM1loAZ79mPJLK.ZkhNyXnqWRsp_zBfNo1d.sj8ZPa79E.5MwOGyE897
 wlfEz94ao8J52jSHo9mdn1aj6lSQ76KrhRNTfMEvIGog6dru.Q_4_lgINpWNQaIE5olV2kF8Agcl
 hBZxDtY.LLxZZSuQpcLeIu2KjYj_IioOq4COOxbi4JBi88YWTCHm_ZD8BnA3FJqhaHDm.pkpyyac
 kZkozxp42egIQgtVIdmRY_659d.3oURsfa5ceziFqpM486Q88uQ3cSwgnph85LiJ8xfyjdOYyFyM
 ed6fQofoT0AnbgF7vYshhVARihRuAB1nBiQAdkjqs.uXOi2slXdCFIjh0q_u2orHHh9Y74wwDGCw
 jWdUL.mmKbsPZndek2vBfbmnpGRSSDGJ5NdGfcNzCGZNcCaZ48hi70BZSx6TeHcSXTCL399k2Yh3
 OUArX0lkG1T7VQ.90ez7.Ag3C65.ixUYR4Pg6Mud6aXUBA6hH9bQY0WuSb8y8U3YEJxMLEMZkuDb
 GIGDO0jd0mHZI3AoQ8GG5z9L93gg0MRdwP0gVON2akRkuVkYhyueuoIhhQRncOU62pFtqW6zZW3L
 80dME7D9iig.rDNq6EOMDWhGD_ucQi5rq7vIZ3NJfKL2kBjfu7eBEjsD4F1glfiF2Z_OLWcd5CQp
 g7VpNQgQHqOFbOfrOn78KODwVk0F8tJAgnVkqu1sqjMadp4YW0ILr51Q2r.SSy3EhQNSz6A_Z68b
 oJf1j9iC1CxRFHh7nSmC4cLR8lqsFnk3DB2xztkDMQW_90YlnwmH.AQiABnFSVdl1WY71MxlO8VC
 APyFfQyh.deR35azgc3phG3WwrgoXQWw.xAKlEQoTAgiODYIWgL8fDr.iml2H40abdO1Zv0tYK5f
 vJSyKpPJmEu.iNu.oXLqryPV..Vd1VydhPyxwReudJxkRLilAHtflo4QySHh2uGFBkH2QaxVewwJ
 IK023.AzJfZaOmyX72XEQqGpNGiYgd7o3hNySpg0jorbuNpcDXkm_2yoPYdMloi6Iwx7UWJxBjsH
 rm28YZ_1gWBhr0DH168OdVbBYimO4XnvbtQ20DQr82wTu4JjIsiUkXVukDB5dc8Ov8IADpfdqFVU
 YSskU8cofAkSdbEla10lLYE3afcLRKwcVmAsV0cHeCMYBB_w4w8.VFRS7_KeiWn6Bnq91G16ej7.
 xTAk7DsJn4tIIO1WA5Pzi821LiMn2Y6mKD4riE98XAc9H6ia7.jNwDpkdtU5ZOcbm8Utw0VxVflk
 y83Z9DDxKoUE1kKiWC74vCYrlNVVYd.UnylaCYqgEghq.fOZnN71ituo-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.ne1.yahoo.com with HTTP; Tue, 3 Sep 2019 20:56:42 +0000
Received: by smtp405.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID cf50a1e79dee65fab01d83b412b83375;
          Tue, 03 Sep 2019 20:56:38 +0000 (UTC)
Subject: Re: [PATCH] Smack: Move request_buffer from stack to smack_audit_data
To:     Denis Efremov <efremov@linux.com>
Cc:     "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, casey@schaufler-ca.com
References: <20190903180134.16176-1-efremov@linux.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Openpgp: preference=signencrypt
Autocrypt: addr=casey@schaufler-ca.com; keydata=
 mQINBFzV9HABEAC/mmv3jeJyF7lR7QhILYg1+PeBLIMZv7KCzBSc/4ZZipoWdmr77Lel/RxQ
 1PrNx0UaM5r6Hj9lJmJ9eg4s/TUBSP67mTx+tsZ1RhG78/WFf9aBe8MSXxY5cu7IUwo0J/CG
 vdSqACKyYPV5eoTJmnMxalu8/oVUHyPnKF3eMGgE0mKOFBUMsb2pLS/enE4QyxhcZ26jeeS6
 3BaqDl1aTXGowM5BHyn7s9LEU38x/y2ffdqBjd3au2YOlvZ+XUkzoclSVfSR29bomZVVyhMB
 h1jTmX4Ac9QjpwsxihT8KNGvOM5CeCjQyWcW/g8LfWTzOVF9lzbx6IfEZDDoDem4+ZiPsAXC
 SWKBKil3npdbgb8MARPes2DpuhVm8yfkJEQQmuLYv8GPiJbwHQVLZGQAPBZSAc7IidD2zbf9
 XAw1/SJGe1poxOMfuSBsfKxv9ba2i8hUR+PH7gWwkMQaQ97B1yXYxVEkpG8Y4MfE5Vd3bjJU
 kvQ/tOBUCw5zwyIRC9+7zr1zYi/3hk+OG8OryZ5kpILBNCo+aePeAJ44znrySarUqS69tuXd
 a3lMPHUJJpUpIwSKQ5UuYYkWlWwENEWSefpakFAIwY4YIBkzoJ/t+XJHE1HTaJnRk6SWpeDf
 CreF3+LouP4njyeLEjVIMzaEpwROsw++BX5i5vTXJB+4UApTAQARAQABtChDYXNleSBTY2hh
 dWZsZXIgPGNhc2V5QHNjaGF1Zmxlci1jYS5jb20+iQJUBBMBCAA+FiEEC+9tH1YyUwIQzUIe
 OKUVfIxDyBEFAlzV9HACGwMFCRLMAwAFCwkIBwIGFQoJCAsCBBYCAwECHgECF4AACgkQOKUV
 fIxDyBG6ag/6AiRl8yof47YOEVHlrmewbpnlBTaYNfJ5cZflNRKRX6t4bp1B2YV1whlDTpiL
 vNOwFkh+ZE0eI5M4x8Gw2Oiok+4Q5liA9PHTozQYF+Ia+qdL5EehfbLGoEBqklpGvG3h8JsO
 7SvONJuFDgvab/U/UriDYycJwzwKZuhVtK9EMpnTtUDyP3DY+Q8h7MWsniNBLVXnh4yBIEJg
 SSgDn3COpZoFTPGKE+rIzioo/GJe8CTa2g+ZggJiY/myWTS3quG0FMvwvNYvZ4I2g6uxSl7n
 bZVqAZgqwoTAv1HSXIAn9muwZUJL03qo25PFi2gQmX15BgJKQcV5RL0GHFHRThDS3IyadOgK
 P2j78P8SddTN73EmsG5OoyzwZAxXfck9A512BfVESqapHurRu2qvMoUkQaW/2yCeRQwGTsFj
 /rr0lnOBkyC6wCmPSKXe3dT2mnD5KnCkjn7KxLqexKt4itGjJz4/ynD/qh+gL7IPbifrQtVH
 JI7cr0fI6Tl8V6efurk5RjtELsAlSR6fKV7hClfeDEgLpigHXGyVOsynXLr59uE+g/+InVic
 jKueTq7LzFd0BiduXGO5HbGyRKw4MG5DNQvC//85EWmFUnDlD3WHz7Hicg95D+2IjD2ZVXJy
 x3LTfKWdC8bU8am1fi+d6tVEFAe/KbUfe+stXkgmfB7pxqW5Ag0EXNX0cAEQAPIEYtPebJzT
 wHpKLu1/j4jQcke06Kmu5RNuj1pEje7kX5IKzQSs+CPH0NbSNGvrA4dNGcuDUTNHgb5Be9hF
 zVqRCEvF2j7BFbrGe9jqMBWHuWheQM8RRoa2UMwQ704mRvKr4sNPh01nKT52ASbWpBPYG3/t
 WbYaqfgtRmCxBnqdOx5mBJIBh9Q38i63DjQgdNcsTx2qS7HFuFyNef5LCf3jogcbmZGxG/b7
 yF4OwmGsVc8ufvlKo5A9Wm+tnRjLr/9Mn9vl5Xa/tQDoPxz26+aWz7j1in7UFzAarcvqzsdM
 Em6S7uT+qy5jcqyuipuenDKYF/yNOVSNnsiFyQTFqCPCpFihOnuaWqfmdeUOQHCSo8fD4aRF
 emsuxqcsq0Jp2ODq73DOTsdFxX2ESXYoFt3Oy7QmIxeEgiHBzdKU2bruIB5OVaZ4zWF+jusM
 Uh+jh+44w9DZkDNjxRAA5CxPlmBIn1OOYt1tsphrHg1cH1fDLK/pDjsJZkiH8EIjhckOtGSb
 aoUUMMJ85nVhN1EbU/A3DkWCVFEA//Vu1+BckbSbJKE7Hl6WdW19BXOZ7v3jo1q6lWwcFYth
 esJfk3ZPPJXuBokrFH8kqnEQ9W2QgrjDX3et2WwZFLOoOCItWxT0/1QO4ikcef/E7HXQf/ij
 Dxf9HG2o5hOlMIAkJq/uLNMvABEBAAGJAjwEGAEIACYWIQQL720fVjJTAhDNQh44pRV8jEPI
 EQUCXNX0cAIbDAUJEswDAAAKCRA4pRV8jEPIEWkzEACKFUnpp+wIVHpckMfBqN8BE5dUbWJc
 GyQ7wXWajLtlPdw1nNw0Wrv+ob2RCT7qQlUo6GRLcvj9Fn5tR4hBvR6D3m8aR0AGHbcC62cq
 I7LjaSDP5j/em4oVL2SMgNTrXgE2w33JMGjAx9oBzkxmKUqprhJomPwmfDHMJ0t7y39Da724
 oLPTkQDpJL1kuraM9TC5NyLe1+MyIxqM/8NujoJbWeQUgGjn9uxQAil7o/xSCjrWCP3kZDID
 vd5ZaHpdl8e1mTExQoKr4EWgaMjmD/a3hZ/j3KfTVNpM2cLfD/QwTMaC2fkK8ExMsz+rUl1H
 icmcmpptCwOSgwSpPY1Zfio6HvEJp7gmDwMgozMfwQuT9oxyFTxn1X3rn1IoYQF3P8gsziY5
 qtTxy2RrgqQFm/hr8gM78RhP54UPltIE96VywviFzDZehMvuwzW//fxysIoK97Y/KBZZOQs+
 /T+Bw80Pwk/dqQ8UmIt2ffHEgwCTbkSm711BejapWCfklxkMZDp16mkxSt2qZovboVjXnfuq
 wQ1QL4o4t1hviM7LyoflsCLnQFJh6RSBhBpKQinMJl/z0A6NYDkQi6vEGMDBWX/M2vk9Jvwa
 v0cEBfY3Z5oFgkh7BUORsu1V+Hn0fR/Lqq/Pyq+nTR26WzGDkolLsDr3IH0TiAVH5ZuPxyz6
 abzjfg==
Message-ID: <abb71a39-b90f-5384-44e6-dcc01fa8f20b@schaufler-ca.com>
Date:   Tue, 3 Sep 2019 13:56:37 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190903180134.16176-1-efremov@linux.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/3/2019 11:01 AM, Denis Efremov wrote:
> request_buffer is required to describe an access type in a string for
> the audit. The problem here is that the string is saved on the stack
> and then passed by reference to the next function in request field of
> the smack_audit_data structure. Referencing variables on a stack
> and saving them in external data structures is usually considered
> as bad and error-prone practice.

You're adding space to the smack_audit_data structure on the
off chance that the stack might disappear out from under something
this function is calling. If you trace the code path, you'll find
that doesn't happen. I can't say that I see any real value to this
change.

>  Thus, this commit simply moves
> the request_buffer from the stack to the stack_audit_data structure
> and removes the necessity of stack referencing. strcat calls are
> replaced with strlcat calls - a safer analog for strings concatenation
> with bounds checking.

Changing strcat to strlcat (or any variant, for that matter) when
the source is a string constant and the destination size is known
is completely pointless.

>
> Signed-off-by: Denis Efremov <efremov@linux.com>

I appreciate the intention, but I don't see any real value here.
I won't be taking this.

> ---
>  security/smack/smack.h        |  6 +++++-
>  security/smack/smack_access.c | 12 +++---------
>  2 files changed, 8 insertions(+), 10 deletions(-)
>
> diff --git a/security/smack/smack.h b/security/smack/smack.h
> index 62529f382942..9eeefb865dfd 100644
> --- a/security/smack/smack.h
> +++ b/security/smack/smack.h
> @@ -278,7 +278,11 @@ struct smack_audit_data {
>  	const char *function;
>  	char *subject;
>  	char *object;
> -	char *request;
> +#ifdef CONFIG_SECURITY_SMACK_BRINGUP
> +	char request[SMK_NUM_ACCESS_TYPE + 5];
> +#else
> +	char request[SMK_NUM_ACCESS_TYPE + 1];
> +#endif
>  	int result;
>  };
> =20
> diff --git a/security/smack/smack_access.c b/security/smack/smack_acces=
s.c
> index f1c93a7be9ec..99e58d4a9980 100644
> --- a/security/smack/smack_access.c
> +++ b/security/smack/smack_access.c
> @@ -340,11 +340,6 @@ static void smack_log_callback(struct audit_buffer=
 *ab, void *a)
>  void smack_log(char *subject_label, char *object_label, int request,
>  	       int result, struct smk_audit_info *ad)
>  {
> -#ifdef CONFIG_SECURITY_SMACK_BRINGUP
> -	char request_buffer[SMK_NUM_ACCESS_TYPE + 5];
> -#else
> -	char request_buffer[SMK_NUM_ACCESS_TYPE + 1];
> -#endif
>  	struct smack_audit_data *sad;
>  	struct common_audit_data *a =3D &ad->a;
> =20
> @@ -360,7 +355,7 @@ void smack_log(char *subject_label, char *object_la=
bel, int request,
>  		sad->function =3D "unknown";
> =20
>  	/* end preparing the audit data */
> -	smack_str_from_perm(request_buffer, request);
> +	smack_str_from_perm(sad->request, request);
>  	sad->subject =3D subject_label;
>  	sad->object  =3D object_label;
>  #ifdef CONFIG_SECURITY_SMACK_BRINGUP
> @@ -371,14 +366,13 @@ void smack_log(char *subject_label, char *object_=
label, int request,
>  	 * the logging policy says to do so.
>  	 */
>  	if (result =3D=3D SMACK_UNCONFINED_SUBJECT)
> -		strcat(request_buffer, "(US)");
> +		strlcat(sad->request, "(US)", sizeof(sad->request));

Have you ever heard of a C compiler that would not correctly
terminate a constant string? I've been using them for over 40
years and have never seen a case where this was a problem.

>  	else if (result =3D=3D SMACK_UNCONFINED_OBJECT)
> -		strcat(request_buffer, "(UO)");
> +		strlcat(sad->request, "(UO)", sizeof(sad->request));
> =20
>  	if (result > 0)
>  		result =3D 0;
>  #endif
> -	sad->request =3D request_buffer;
>  	sad->result  =3D result;
> =20
>  	common_lsm_audit(a, smack_log_callback, NULL);

