Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F197C072B1
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 20:37:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5583E21670
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 20:37:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="D17yKxTz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727161AbfE1UhO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 16:37:14 -0400
Received: from sonic305-9.consmr.mail.bf2.yahoo.com ([74.6.133.48]:42853 "EHLO
        sonic305-9.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726523AbfE1UhO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 16:37:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1559075832; bh=IHE5WmOl71MWEP+2/TlevzldIC2Y1SSwQQXVOBX/2gg=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=D17yKxTznsnz4HgvUFZMgXqvTOZcNvx/ntTfbh+9XemZD7QGvdnHv1c3CHCwaxFuk7RO6M5T6Ga6qrZjb5MfAn4Kje0XbvlOkwy1WhA41WLKDUrVr1bLBFPAScrybmP8qrMifFxzFsO4Q41j/kC8uB2EuSBRI+OqNCp1MT1UU44v5Q8GYRNBhfD7TxaoiCHsSUxuEXPWN92pbbLkHx4ErGmzEELg2a8d9ujZSXESRFr3JOk/NpNH30CF6eb9eAd6xzgOTF+VkD4L1VQYjXJiDQwI6F+JSLFIr938fbi9PsOa2kv19jH8EtKIyW1oB3An87cx1xyxz+j+spz7OPk+rA==
X-YMail-OSG: 4I72JnEVM1mt7nUGaKmpDjLexe.c4L.gW_TrX42oX30V1MHJMUDmNMbLEJyDhyR
 2QMcYsztFtaQISuCLCQQ4utJKkrc4DzML_aSvTUIa8v9oJ3hYLcQbuSJLRGShFSMv57D0q6VKtnh
 gcIVMFeMe9yF8M2vQKd53lo16YOZENPH_eoUccQcmolKyG4Dg43CNviFU.wZnHMMfxHQ3aYA.qyw
 gkJrkrR7xWixLHohmhMXkWhoDq3vi0rE2XrqZZmqHFx.tTLe4QcLBfPFErLT.UncSfIwfx.OGFfc
 _qTWf.3WEw7WjrGmdXZmJ3gSeEnQM5D7pwedjFvqRLmzNSm3Rwod1PvXNAsizbfQpYzqWYpgCRQN
 JczP9dg5tg710ssuvN1FT3H1C9v2T5n3pHzX9bkEifydnOZysSiXsUtHCLfUE.RvQgKPtVBZ6Esa
 9yZ7.ci_3jIwkt4Nl9vkjhJuxmo0bdxC9LUpnvO_3mHi70jZXC_X_uInZmVjTrEvvLsU4GIlmqsd
 xKUp2xVm1MVVlfujt3xPYHEfxEfSRAVvFa557Y_lzIC0gdtbtlMOnlPT0ppVBccEJ3SInVHZ5OMf
 VH4O73QbMMAFoRthYL76Onr.uv2xjxG4nJEjJrAVqtHMzr3E6BNI3zPudy3ZzqAzqubs0MSak4mS
 OxuuaeSmW..qa7nP9ZuBQsdB4ZdSGZjwVuLsny4Z4A229smPptRRVtgX4OyivRQ6mmQM0UCfIAZg
 4yVxqzxbkQPQOP24p8fxxrxMbHmQkIZ7ParCsx2uPG5B4EM7dpGdHM6P5vIcATmcpq4.JekOOsol
 U1AQqE1sXISsDmqo0ykEgDnaQBbjVO.ssONH387q5aGcMCvrMFbOce5EHy8B6Jj322Dce0_T8WH_
 jKx3dlqfStODg_nsweHTCZ.iR9rDNqzTzGIMwdM_ZPo.XfV76BVwW.Z.oCrNvycSHNuefctJ_2Bf
 DBMi0KvCw77ACC1Q4kC9NlvR0AA9kTXRd5BkriZVJYyp3R_t0cFWuFcsDK18eUlVuLD36qCev5xo
 PaURGbz3mQShpjKcnztawuD9lin6Zso7vMooW6FTKVMU8vLMrYg9Ehxi5XBURyopIkguSN7JaKUY
 8IvDOw30NgBz.H3Y2bEh7HbQB05ZBLXsPb5F_VqILE9KUpV5aPYT9_IqPUAB36K5pFOD_VgwAJ4J
 UJH.lsjzAjDh.PKnEkt1EKt.H6SkQ7LZZZV_q76tCqBHgF21tMEWreVSGxooyKE8usMxW5r4u04h
 PMyeHoGYOfMLYZU1krix0dEXGELBy.mhNKgCq
Received: from sonic.gate.mail.ne1.yahoo.com by sonic305.consmr.mail.bf2.yahoo.com with HTTP; Tue, 28 May 2019 20:37:12 +0000
Received: from c-73-223-4-185.hsd1.ca.comcast.net (EHLO [192.168.0.103]) ([73.223.4.185])
          by smtp420.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 653595a43b06045043212d56a06a0592;
          Tue, 28 May 2019 20:37:08 +0000 (UTC)
Subject: Re: [PULL] Smack: Restore the smackfsdef mount option
To:     David Howells <dhowells@redhat.com>
Cc:     James Morris <jmorris@namei.org>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        LKML <linux-kernel@vger.kernel.org>, casey@schaufler-ca.com
References: <6e061326-5feb-5471-c0c0-a364af5e82c3@schaufler-ca.com>
 <6889f4f9-4ae0-8a92-a2fc-04151ad8ed9f@schaufler-ca.com>
 <10710.1559070135@warthog.procyon.org.uk>
 <15805.1559074726@warthog.procyon.org.uk>
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
Message-ID: <327199b6-a7d3-8c07-fb14-2cc04b370a78@schaufler-ca.com>
Date:   Tue, 28 May 2019 13:37:06 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <15805.1559074726@warthog.procyon.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/28/2019 1:18 PM, David Howells wrote:
> Casey Schaufler <casey@schaufler-ca.com> wrote:
>
>>> 	 static const struct fs_parameter_spec smack_param_specs[] = {
>>> 	+	fsparam_string("fsdef",		Opt_fsdefault),
>>> 		fsparam_string("fsdefault",	Opt_fsdefault),
>>> 		fsparam_string("fsfloor",	Opt_fsfloor),
>>> 		fsparam_string("fshat",		Opt_fshat),
>>>
>>> but that all the option names in that table *do* need prefixing with
>>> "smack".
> Actually, you're right, we do need to add that *and* prefix it with "smack".
>
>> I'm not sure I follow the logic, because "mount -o smackfsdefault=Pop"
>> does what I would expect it to.
> Yes, I'm sure it does - for the cases you're testing - but it's filesystem and
> syscall dependent.  None of the filesystems currently ported to the mount API
> upstream override ->parse_monolithic(), but that changes with nfs, shmem and
> coda and will change with cifs too.
>
> It also changes if you use fsconfig() to supply the options because that goes
> through a different LSM hook (it uses fs_context_parse_param rather than
> sb_eat_lsm_opts).
>
>>> The way you enter the LSM is going to depend on whether
>>> generic_parse_monolithic() is called.  You're only going to enter this way
>>> if mount(2) is the syscall of entry and the filesystem doesn't override
>>> the ->parse_monolithic() option (none in the upstream kernel).
>> So you're saying that the code works for the mount(2) case,
>> but won't work for some other case? Are you planning a fix?
>> Will that fix include restoration of smackfsdef?
> I can do a fix, but testing it is a pain.

I will test a fix if you point me to it. I need it for 5.1 and 5.2.

>
> David
