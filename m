Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CA15C3A5A5
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 08:39:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CD5721848
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 08:39:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="EFN2ZqpF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732754AbfIEIjJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 04:39:09 -0400
Received: from mout.web.de ([212.227.17.12]:39799 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731737AbfIEIjI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 04:39:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1567672730;
        bh=Ft5hMJK7020BtfKPKFnc7o3tvZTcyZbBeF/1eF+84cQ=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=EFN2ZqpF/t5MKPD/G6dSfR9qVjhZOIOcgJQUHvP2xQE1RxAYjmKV8r6OoUibisKck
         9KQfRXry6F2GYHLRRH2ZCPYYSQW7IyqvsyNu8psx6PLDpdLhtSqTIFvWUOh+y1zcoP
         GR35qjqP/wrFl0JVP8dhtUyL7+ApbWpKrxQ9fpPE=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([78.49.131.221]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MY6wu-1hayld3r72-00Urht; Thu, 05
 Sep 2019 10:38:50 +0200
Subject: Re: drm/amdgpu: remove the redundant null check
To:     zhong jiang <zhongjiang@huawei.com>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Cc:     LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
References: <1567491305-18320-1-git-send-email-zhongjiang@huawei.com>
 <62b33279-9ca9-5970-5336-a8511ce54197@web.de> <5D70A196.3020106@huawei.com>
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <dd351754-cb3a-b19a-64e1-f2f583c2a23a@web.de>
Date:   Thu, 5 Sep 2019 10:38:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.0
MIME-Version: 1.0
In-Reply-To: <5D70A196.3020106@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:q+vJcHfZuRXgpnHBi/SPGIVNieL+cgDQJb9MqBM4B/sgw3ZSN/y
 tF+S723TUBC79hzBX0KozPlJrERvZAZ/wURewiRV0EU+8hE0uXAOwUwJi0gbNMa6KMfTq4G
 Q4PV+uSZbRTFqhC2sxIbq11h9FFdLdTgkdNUKU0OFSctWN486s1hV82Yprhr8Q1NWBl2BAB
 BEFU52DpeNktR8f8pzwFA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:KqAeNibHUhU=:l7SmUO9i7oRdvVMVMDR90O
 CUfTUr9asenQwE6moyfQmSc+Fa7kf5+yelaULtOcPJBpfNXAojPFOZhCF0UmeZOWUJRmXDOnm
 eh+V25xXJ70O8mYl3Kci9cyu+hLc5FbpxJTf0HxHPABDsWevG3krKItQ2WcA7McMjhMIVB8y6
 ffSLvbwwQv7VPdp/2ZAPb0Qh7i+YuSIsdpmYtVmWf53HYeW8sSPzKcM0G02H9kbE12iz68FXg
 KUWP5VuuKO6XQX/1Y1FCne3z5Etow1AYyGuJLY9KNQZlEkT/ocP7wbqAeMvTrNXV9takwPWyU
 LXnqTAjmTgTu0VtIOcqdj6ofH3lQpe1wJK4bRBef08F9hHOFYKJ0u7FSPpt9UGzChi4ghfh4t
 ZNB2iK/zIxbnF7TVtGBZqV2vwY+ms4tGpOtq5Tagm0S1Hhs9Hep+ykXi3Ixa8R2RVF3F59jOb
 Exo641RU1hdm96rn5t5/E5f6ebRWBjbEzz5QouFw3U79Uj1p2yCNyItXXZZGkCYwXESsWZW+J
 rO7pGv244sT9yzQpueRwf/PqBlIl4tXP96sZKYEXfK2kCyzFdq3FhsCM0G1w1SuWPyKDKPHVM
 gzx0qVIKg+FCmynlC8N7IskbKW9xsQEoMCCUSQuzYquCfsY2PA8LU7n6vbnuowCYkxQvTY3TR
 MRTkxvqMD/GNqwtQLwh6HaDJkl/geLuZJnXljdTMmbTNjlWi6B/meGuN6oQVO8EtU/EqTwz02
 STMKMeIiqDidINXNaLK1A6IKC6/rwLCB8y4Mpm1i6YBhI1DEKEYaNCtYTiNoElZTaQcl7E5hw
 M8vRZ1xdHd0zMUv8I0MMwD4JNSR8StXOdjlro9iwQ5SmFrnlFJaFZfNGoOhvfKcSRwQ8Z0VlG
 8c9DtH7qvBxypzO/RJgo030pHXcvzSicpP1Lw2Kppn65Xe++de+Hj+NUk+cO/v2UUvDvSfmjU
 D9QkrIdDC4qupdGQcji6Mr6hRsNoLpkm6w75iI9k9f5uOjYxMtGBgaPuac75fX5mj0NoZE1bB
 B/wla5V86v18kbXIqo78NLZSz4Lx46J+9TXo95XGkdJsoaFTHbpyU05u6XZikNiKqKb8c5nUp
 0t8bR7xGgwRxJJ4nVpbzhZx6KFlEtGptnTRtwpKWO3As1j2Iu8XDszRI1XJK1fS8Y+9ug0Uis
 d+dNpOt2N5XtBTFuFApS5QolkrgGjSI/maHw626el9xM0EB3Am0d0c2p5IwgnNAH06V36QMBo
 I7jTRlbk5pFqDcNAY
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> Were any source code analysis tools involved for finding
>> these update candidates?
> With the help of Coccinelle. You can find out some example in scripts/co=
ccinelle/.

Thanks for such background information.
Was the script =E2=80=9Cifnullfree.cocci=E2=80=9D applied here?

Will it be helpful to add attribution for such tools
to any more descriptions in your patches?

Regards,
Markus
