Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31DBFC43331
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 17:20:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF4BE21848
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 17:20:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="QLUtDsxA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406040AbfIFRUV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 13:20:21 -0400
Received: from esa5.hc3370-68.iphmx.com ([216.71.155.168]:9757 "EHLO
        esa5.hc3370-68.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729928AbfIFRUV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 13:20:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1567790421;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=qeeK53CmUVpimQY4XyObm5+VCGlzzOrVpjRw3ci6u0E=;
  b=QLUtDsxAsoOtdWZx79F8TnQW0x6EEuyYh5Q+ed9t+3JUai2n0g9UYmnD
   KE6yZJeQYrsJwmS33CIcvXPDWuuoNC/Dtn9eZbS/TyjNIz5YZABr6nxJW
   mRRXV7RPg/qM2+rmCPyX9D2QgCblJERgcpD8JrBOfVurEk8VlhYDz0kJk
   s=;
Authentication-Results: esa5.hc3370-68.iphmx.com; dkim=none (message not signed) header.i=none; spf=None smtp.pra=andrew.cooper3@citrix.com; spf=Pass smtp.mailfrom=Andrew.Cooper3@citrix.com; spf=None smtp.helo=postmaster@mail.citrix.com
Received-SPF: None (esa5.hc3370-68.iphmx.com: no sender
  authenticity information available from domain of
  andrew.cooper3@citrix.com) identity=pra;
  client-ip=162.221.158.21; receiver=esa5.hc3370-68.iphmx.com;
  envelope-from="Andrew.Cooper3@citrix.com";
  x-sender="andrew.cooper3@citrix.com";
  x-conformance=sidf_compatible
Received-SPF: Pass (esa5.hc3370-68.iphmx.com: domain of
  Andrew.Cooper3@citrix.com designates 162.221.158.21 as
  permitted sender) identity=mailfrom;
  client-ip=162.221.158.21; receiver=esa5.hc3370-68.iphmx.com;
  envelope-from="Andrew.Cooper3@citrix.com";
  x-sender="Andrew.Cooper3@citrix.com";
  x-conformance=sidf_compatible; x-record-type="v=spf1";
  x-record-text="v=spf1 ip4:209.167.231.154 ip4:178.63.86.133
  ip4:195.66.111.40/30 ip4:85.115.9.32/28 ip4:199.102.83.4
  ip4:192.28.146.160 ip4:192.28.146.107 ip4:216.52.6.88
  ip4:216.52.6.188 ip4:162.221.158.21 ip4:162.221.156.83 ~all"
Received-SPF: None (esa5.hc3370-68.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@mail.citrix.com) identity=helo;
  client-ip=162.221.158.21; receiver=esa5.hc3370-68.iphmx.com;
  envelope-from="Andrew.Cooper3@citrix.com";
  x-sender="postmaster@mail.citrix.com";
  x-conformance=sidf_compatible
IronPort-SDR: rcREu77It/eYYutMUs3ZpTr1Tc9PPQpSBp98e+PFLmK4iOwMeEC9z2pohOIkKkUW9wsF3vjRho
 CiWf8tuCStKBTGiwY4QaX1ceDMGax7az8uDkRpH8ieDB+hhdheQWFvPgqIEOTAajgs6id04Z6r
 ykNydJ0E0F9fdhVwBzM3fIURLPvoD1iqyHfD2X+6DZT3YwIZ//YdUSCZMmSFaNen5y8tTV2riH
 Nc11j+od1tfLqXxCUGybnmq9PsyZufe6rEU9OgfR/xQfgesWnXI4Eb+kjaDwgm9qerDLWQXI63
 fm4=
X-SBRS: 2.7
X-MesageID: 5436483
X-Ironport-Server: esa5.hc3370-68.iphmx.com
X-Remote-IP: 162.221.158.21
X-Policy: $RELAYED
X-IronPort-AV: E=Sophos;i="5.64,473,1559534400"; 
   d="scan'208";a="5436483"
Subject: Re: [Xen-devel] [PATCH] ARM: xen: unexport HYPERVISOR_platform_op
 function
To:     Arnd Bergmann <arnd@arndb.de>
CC:     Stefano Stabellini <sstabellini@kernel.org>,
        Emil Velikov <emil.l.velikov@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "Denis Efremov" <efremov@linux.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        xen-devel <xen-devel@lists.xenproject.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Julien Grall <julien.grall@arm.com>
References: <20190906153948.2160342-1-arnd@arndb.de>
 <7abad95e-ea47-c068-d91c-ba503f2530b9@citrix.com>
 <CAK8P3a1qkMLW_Wnn-N0seUw4N5bPwTU7Dy7CwOWxzS6NTnTmiQ@mail.gmail.com>
From:   Andrew Cooper <andrew.cooper3@citrix.com>
Openpgp: preference=signencrypt
Autocrypt: addr=andrew.cooper3@citrix.com; prefer-encrypt=mutual; keydata=
 mQINBFLhNn8BEADVhE+Hb8i0GV6mihnnr/uiQQdPF8kUoFzCOPXkf7jQ5sLYeJa0cQi6Penp
 VtiFYznTairnVsN5J+ujSTIb+OlMSJUWV4opS7WVNnxHbFTPYZVQ3erv7NKc2iVizCRZ2Kxn
 srM1oPXWRic8BIAdYOKOloF2300SL/bIpeD+x7h3w9B/qez7nOin5NzkxgFoaUeIal12pXSR
 Q354FKFoy6Vh96gc4VRqte3jw8mPuJQpfws+Pb+swvSf/i1q1+1I4jsRQQh2m6OTADHIqg2E
 ofTYAEh7R5HfPx0EXoEDMdRjOeKn8+vvkAwhviWXTHlG3R1QkbE5M/oywnZ83udJmi+lxjJ5
 YhQ5IzomvJ16H0Bq+TLyVLO/VRksp1VR9HxCzItLNCS8PdpYYz5TC204ViycobYU65WMpzWe
 LFAGn8jSS25XIpqv0Y9k87dLbctKKA14Ifw2kq5OIVu2FuX+3i446JOa2vpCI9GcjCzi3oHV
 e00bzYiHMIl0FICrNJU0Kjho8pdo0m2uxkn6SYEpogAy9pnatUlO+erL4LqFUO7GXSdBRbw5
 gNt25XTLdSFuZtMxkY3tq8MFss5QnjhehCVPEpE6y9ZjI4XB8ad1G4oBHVGK5LMsvg22PfMJ
 ISWFSHoF/B5+lHkCKWkFxZ0gZn33ju5n6/FOdEx4B8cMJt+cWwARAQABtClBbmRyZXcgQ29v
 cGVyIDxhbmRyZXcuY29vcGVyM0BjaXRyaXguY29tPokCOgQTAQgAJAIbAwULCQgHAwUVCgkI
 CwUWAgMBAAIeAQIXgAUCWKD95wIZAQAKCRBlw/kGpdefoHbdD/9AIoR3k6fKl+RFiFpyAhvO
 59ttDFI7nIAnlYngev2XUR3acFElJATHSDO0ju+hqWqAb8kVijXLops0gOfqt3VPZq9cuHlh
 IMDquatGLzAadfFx2eQYIYT+FYuMoPZy/aTUazmJIDVxP7L383grjIkn+7tAv+qeDfE+txL4
 SAm1UHNvmdfgL2/lcmL3xRh7sub3nJilM93RWX1Pe5LBSDXO45uzCGEdst6uSlzYR/MEr+5Z
 JQQ32JV64zwvf/aKaagSQSQMYNX9JFgfZ3TKWC1KJQbX5ssoX/5hNLqxMcZV3TN7kU8I3kjK
 mPec9+1nECOjjJSO/h4P0sBZyIUGfguwzhEeGf4sMCuSEM4xjCnwiBwftR17sr0spYcOpqET
 ZGcAmyYcNjy6CYadNCnfR40vhhWuCfNCBzWnUW0lFoo12wb0YnzoOLjvfD6OL3JjIUJNOmJy
 RCsJ5IA/Iz33RhSVRmROu+TztwuThClw63g7+hoyewv7BemKyuU6FTVhjjW+XUWmS/FzknSi
 dAG+insr0746cTPpSkGl3KAXeWDGJzve7/SBBfyznWCMGaf8E2P1oOdIZRxHgWj0zNr1+ooF
 /PzgLPiCI4OMUttTlEKChgbUTQ+5o0P080JojqfXwbPAyumbaYcQNiH1/xYbJdOFSiBv9rpt
 TQTBLzDKXok86LkCDQRS4TZ/ARAAkgqudHsp+hd82UVkvgnlqZjzz2vyrYfz7bkPtXaGb9H4
 Rfo7mQsEQavEBdWWjbga6eMnDqtu+FC+qeTGYebToxEyp2lKDSoAsvt8w82tIlP/EbmRbDVn
 7bhjBlfRcFjVYw8uVDPptT0TV47vpoCVkTwcyb6OltJrvg/QzV9f07DJswuda1JH3/qvYu0p
 vjPnYvCq4NsqY2XSdAJ02HrdYPFtNyPEntu1n1KK+gJrstjtw7KsZ4ygXYrsm/oCBiVW/OgU
 g/XIlGErkrxe4vQvJyVwg6YH653YTX5hLLUEL1NS4TCo47RP+wi6y+TnuAL36UtK/uFyEuPy
 wwrDVcC4cIFhYSfsO0BumEI65yu7a8aHbGfq2lW251UcoU48Z27ZUUZd2Dr6O/n8poQHbaTd
 6bJJSjzGGHZVbRP9UQ3lkmkmc0+XCHmj5WhwNNYjgbbmML7y0fsJT5RgvefAIFfHBg7fTY/i
 kBEimoUsTEQz+N4hbKwo1hULfVxDJStE4sbPhjbsPCrlXf6W9CxSyQ0qmZ2bXsLQYRj2xqd1
 bpA+1o1j2N4/au1R/uSiUFjewJdT/LX1EklKDcQwpk06Af/N7VZtSfEJeRV04unbsKVXWZAk
 uAJyDDKN99ziC0Wz5kcPyVD1HNf8bgaqGDzrv3TfYjwqayRFcMf7xJaL9xXedMcAEQEAAYkC
 HwQYAQgACQUCUuE2fwIbDAAKCRBlw/kGpdefoG4XEACD1Qf/er8EA7g23HMxYWd3FXHThrVQ
 HgiGdk5Yh632vjOm9L4sd/GCEACVQKjsu98e8o3ysitFlznEns5EAAXEbITrgKWXDDUWGYxd
 pnjj2u+GkVdsOAGk0kxczX6s+VRBhpbBI2PWnOsRJgU2n10PZ3mZD4Xu9kU2IXYmuW+e5KCA
 vTArRUdCrAtIa1k01sPipPPw6dfxx2e5asy21YOytzxuWFfJTGnVxZZSCyLUO83sh6OZhJkk
 b9rxL9wPmpN/t2IPaEKoAc0FTQZS36wAMOXkBh24PQ9gaLJvfPKpNzGD8XWR5HHF0NLIJhgg
 4ZlEXQ2fVp3XrtocHqhu4UZR4koCijgB8sB7Tb0GCpwK+C4UePdFLfhKyRdSXuvY3AHJd4CP
 4JzW0Bzq/WXY3XMOzUTYApGQpnUpdOmuQSfpV9MQO+/jo7r6yPbxT7CwRS5dcQPzUiuHLK9i
 nvjREdh84qycnx0/6dDroYhp0DFv4udxuAvt1h4wGwTPRQZerSm4xaYegEFusyhbZrI0U9tJ
 B8WrhBLXDiYlyJT6zOV2yZFuW47VrLsjYnHwn27hmxTC/7tvG3euCklmkn9Sl9IAKFu29RSo
 d5bD8kMSCYsTqtTfT6W4A3qHGvIDta3ptLYpIAOD2sY3GYq2nf3Bbzx81wZK14JdDDHUX2Rs
 6+ahAA==
Message-ID: <bda2a05b-e2d0-feee-761b-88deeeac2449@citrix.com>
Date:   Fri, 6 Sep 2019 18:20:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAK8P3a1qkMLW_Wnn-N0seUw4N5bPwTU7Dy7CwOWxzS6NTnTmiQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
X-ClientProxiedBy: AMSPEX02CAS02.citrite.net (10.69.22.113) To
 AMSPEX02CL01.citrite.net (10.69.22.125)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/09/2019 17:00, Arnd Bergmann wrote:
> On Fri, Sep 6, 2019 at 5:55 PM Andrew Cooper <andrew.cooper3@citrix.com> wrote:
>> On 06/09/2019 16:39, Arnd Bergmann wrote:
>>> HYPERVISOR_platform_op() is an inline function and should not
>>> be exported. Since commit 15bfc2348d54 ("modpost: check for
>>> static EXPORT_SYMBOL* functions"), this causes a warning:
>>>
>>> WARNING: "HYPERVISOR_platform_op" [vmlinux] is a static EXPORT_SYMBOL_GPL
>>>
>>> Remove the extraneous export.
>>>
>>> Fixes: 15bfc2348d54 ("modpost: check for static EXPORT_SYMBOL* functions")
>>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>> Something is wonky.  That symbol is (/ really ought to be) in the
>> hypercall page and most definitely not inline.
>>
>> Which tree is that changeset from?  I can't find the SHA.
> This is from linux-next, I think from the kbuild tree.

Thanks.

Julien/Stefano: Why are any of these hypercalls out-of-line?  ARM
doesn't use the hypercall page, and there is no argument translation
(not even in arm32 as there are no 5-argument hypercalls declared).

They'd surely be easier to implement with a few static inlines and some
common code, than to try and replicate the x86 side hypercall_page
interface ?

~Andrew
