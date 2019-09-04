Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97A42C3A5AB
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 21:07:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CEEE21883
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 21:07:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="SAvPN6si"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730759AbfIDVHa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 17:07:30 -0400
Received: from sonic307-15.consmr.mail.ne1.yahoo.com ([66.163.190.38]:43372
        "EHLO sonic307-15.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730326AbfIDVHa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 17:07:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1567631248; bh=RhEop4PVI8H1dbALrbguPvRkK+KL8XagKnez+upUMns=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=SAvPN6siR0jvmsoBM9RCTV0TZ/piT2Ryq/mwt2foRZP6HA0djI9/XBoiH3THft5NEu4AJy1UKGT8jzlb7IWqR4Dn0iugWpQ1LY0dJ0XuBCObH8ZfsIQ7zgciK76an4EJzKLatnunh8rwyA19V5wPUm5oRvt6g1U6OEAq0+0mjqmn1G84P6FyEfH1MTemplpDIYEQQL51BXruNw9bT2aJ4pVhyaN28kwxFu2AZx1jVXngqBofkJT3AdXp5/JVhOXuLznfTA4Y8nryT95eaCjtfAQ3X4xyeMjUg+S5jbtC0ZXGz1UdF77uxXVf+5lNccOXjCkeV6Xv9EniNv1pMkoO/g==
X-YMail-OSG: fBjVJNcVM1mtH5rzWvkoTnTSnFP2l38VcZCCg1kJvoVGfQFXdx1.xB.bn_Wfhtr
 EUgoo4O7.uX9sZhP0M37pyiFm5Zv_yVVHMAeUvAzDM1X0MCCD1h91DRZOTuolQv9l9niyQ8PTaJo
 BAfPGUfkWQRRLXVi_7WCLG3aiy7rydGkE0WzyB3ClcE218pk4sB_QgJBZcfca__KrjuT9_QVSW4r
 IKfGpk5jEzSxRkzCLTV5IdEwLVWQ2WMHFXDBOEIFNNM9rVY4dmSnMWek81Iz0o.1X8hKdjsc1YZj
 KPAJjj00JGd3W_dqoga7my8nwsZ_W83l_t87SM4uNKVM2SGr6ANzyWIV81s6HrG8LLN5EGeEL9Ta
 kCOegtB8Yg5nb.Z2AI695pxzsL49uaKBwznSvToYTjMJsAcKqfoISAolf9T9rxfVYF_xcbiCUZtx
 lewMTEtMXHPSnopJ4x7bcN5GOPneJsOvWiOWIS620u5iACuiOHnaRokQLV48CbLvxNpIK0Lfbqu8
 l6m0Ljrq6mst.QrloariMsDiUb_UKDYgCN__WDMW6y9PTwQzvuW0fxh3ZFEfJ9LOLHWGYHZYT_vc
 VJ.Ra.Ubd7V4M7YHnySDaND9amxW28VFOOgB3qiZRLEDfqHsXKKgE9NmR0qhijy_N8D0xB6FxVq7
 GAGI9xjDR3CRcBep8z2GJh8FMXNJuefbQAqszvGMrunQ9CZTDyxfCI.GG6SXn7hZI33dhKze.cHJ
 ioHF00W7Nt1VPAwtFf0UEkfWXJ0LY_NFjHZZmiAXbAYKsH.TFGpqxzls0VYc7GLXwGQEzvFPKjc7
 b1JM_P8rRf8X18EcGhUQEqJQZcQKu0L094mRKPocGw76WUcgJjdsMENl1HKfp_i4fMOhy5wJ3FGw
 ylcJEkOIaago.y1o68a34HYSqoIC0n14q2CjjYbQwDWBPvycOx.SSc1hQMMvE.e8nSvP9KlCNl2k
 PlI7ucO.t9EqF_UYe1vzlyvb3FGWTx8FG7pCcq0zSgtyRIMIOxQE3pP9j36mAr9EfzMsNwvgIXqJ
 iv26pVYvA3oIQ65KlJtt26oeIGMCO1sQPXQhZiuZuMayVcRqSdedXzusCO7FkyY8FIQ9xP0fygpu
 fPn3TWitY_Ozh9Xj3zjhmN.TDcGNrBcGef4WmBXU4HIhCOruP0re21.Kpxtm4rx8H1clKbAql2u2
 KZvzXO.b9Wz5pOyOXoVXCYHjA.PuJrvqKUn78pA8TTUXlKjuADtkXelgB3ocmXuKan4.leGXoiN0
 deBsNh0B.N._ioesyfYSQ7NT7JfVmF5VBewvRZ_pWJwx8nTxFtFaXFjzZEApgFzlLcOvtsKUlIb6
 EXRB8JE3eNrmKOiaqiPzo7vjhpkFC0D7J0Iraq6FKEU3X4g--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic307.consmr.mail.ne1.yahoo.com with HTTP; Wed, 4 Sep 2019 21:07:28 +0000
Received: by smtp425.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 98bb798431c2a3d4d593a02f1210888d;
          Wed, 04 Sep 2019 21:07:27 +0000 (UTC)
Subject: Re: general protection fault in smack_socket_sendmsg
To:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Hillf Danton <hdanton@sina.com>,
        syzbot <syzbot+5fd781d646d4fcbdfeb0@syzkaller.appspotmail.com>
Cc:     jmorris@namei.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, serge@hallyn.com,
        syzkaller-bugs@googlegroups.com
References: <20190831053311.15704-1-hdanton@sina.com>
 <5f34b914-ca5b-e527-9183-64dc0d83ec9f@schaufler-ca.com>
 <b2a7cbb6-2243-d591-41e7-955e1e1e4785@I-love.SAKURA.ne.jp>
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
Message-ID: <2848be95-7ec0-dd6d-7119-d78a2fe49679@schaufler-ca.com>
Date:   Wed, 4 Sep 2019 14:07:23 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <b2a7cbb6-2243-d591-41e7-955e1e1e4785@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/4/2019 3:16 AM, Tetsuo Handa wrote:
> On 2019/09/04 8:17, Casey Schaufler wrote:
>> On 8/30/2019 10:33 PM, Hillf Danton wrote:
>>>> dashboard link: https://syzkaller.appspot.com/bug?extid=3D5fd781d646=
d4fcbdfeb0
>> If you want to add a description and signed-off-by I will take this.
> Excuse me, but this bug was already closed as dup of "KASAN: use-after-=
free Read in rxrpc_send_keepalive".

I will hold off then. Thanks.


