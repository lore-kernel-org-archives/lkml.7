Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 097E9C4360C
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 04:59:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE24E2133F
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 04:59:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ucr.edu header.i=@ucr.edu header.b="EB1nDzZv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388020AbfJDE70 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 00:59:26 -0400
Received: from mx2.ucr.edu ([138.23.62.3]:23623 "EHLO mx2.ucr.edu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387872AbfJDE70 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 00:59:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=ucr.edu; i=@ucr.edu; q=dns/txt; s=selector3;
  t=1570165166; x=1601701166;
  h=mime-version:from:date:message-id:subject:to;
  bh=A+I6D9bcXImXXHQXTN8cFXRlKcVCgK2hO1c0i9JFMJY=;
  b=EB1nDzZvstsf+hW7OSqKeElvVTxZoCucjN7e1cfxQvsuuDw6aZC0zIsY
   z2lKCAbygPfLpDWuLH5Jgc/6JM9gRjTSKcXvQJ8xqLp2o/AEb9kj+dFke
   EMUwe/yH7loHUVbte56aqetefMFN+mhiMe6bkfYQwTueFhUXnJ2kPZgfp
   kffyRnCXhTOc/iZzCSQ5ASosBIf8IEjH7wkSiGEkpDUg3M3CghTcekouP
   BpyZLeJ59yNsq/gF+Mi8tlhU0JzijObEk/5i3SLG1gT11jqyvWYYO90FU
   xwUm5kNDjh3pSayGlnfpvIFGcNk93u8QkgZ1Uu8ie9lGAp68VzMvDv5WY
   g==;
IronPort-SDR: KbCMOa9n++51x6QKh9WuBtdqR1gWXhm/B7m/2ZHFlcBzIhqWGleZIZ3iMqlENgpREpl7YGoxzY
 QDMWdOSiud0XpuYG2lcfs99klSQviLsfhjtVM6xPkqIzkkoVHsYvvY7DH8veeru0jjhUlXjXeE
 eY69Z7k+5/9MOEUVKNWxkQSn1WVAGjLqmjzIWbYA7JUWQm6G6thyh6zSANTtcP3YAXhM5snf8o
 vxIAM1bCJITBwAz5fsjlBrXCDuhwUwKaPhwJvCDFYAkxIsl6YuNcJbF8SBwFV3CKL7OME1LN+q
 b1o=
IronPort-PHdr: =?us-ascii?q?9a23=3AFpV2TBEb2JOIS/mVlE9CJ51GYnF86YWxBRYc79?=
 =?us-ascii?q?8ds5kLTJ7zosywAkXT6L1XgUPTWs2DsrQY0rGQ7virAzBIyK3CmUhKSIZLWR?=
 =?us-ascii?q?4BhJdetC0bK+nBN3fGKuX3ZTcxBsVIWQwt1Xi6NU9IBJS2PAWK8TW94jEIBx?=
 =?us-ascii?q?rwKxd+KPjrFY7OlcS30P2594HObwlSizexfL1/IA+2oAnNucUan4RvIbstxx?=
 =?us-ascii?q?XUpXdFZ/5Yzn5yK1KJmBb86Maw/Jp9/ClVpvks6c1OX7jkcqohVbBXAygoPG?=
 =?us-ascii?q?4z5M3wqBnMVhCP6WcGUmUXiRVHHQ7I5wznU5jrsyv6su192DSGPcDzULs5Vy?=
 =?us-ascii?q?iu47ttRRT1kyoMKSI3/3/LhcxxlKJboQyupxpjw47PfYqZMONycr7Bcd8GQG?=
 =?us-ascii?q?ZMWNtaWS5cDYOmd4YAAOoPM+hboYfguVUBsQCzBRWwCO711jNEmmP60K883u?=
 =?us-ascii?q?88EQ/GxgsgH9cWvXvWrdX0NacSUf2yzKLVzjrDb+lZ2Tbg44XPchEgoPGMUq?=
 =?us-ascii?q?hxccbN1UUiGRjIjkiMpoz/JT+ayPkCs3WC4udmSOmhiHYnphlvrjSzwsogkI?=
 =?us-ascii?q?rEi4IPxlzZ9Ch0wpw5KN+kREN9fNWqCoFftzuAOItzWs4iRmZotzskxbAeop?=
 =?us-ascii?q?67eTQKyIwgxx7Cd/yLa4iI7QznVOaWOTp4gWhqeLO7hxqr9UigxPDwWtC60F?=
 =?us-ascii?q?tIsiZJiNbMtncK1xzc7siIVOFx8Vum2TaKzwzT6+dELl4olafDNZIt3ro9mo?=
 =?us-ascii?q?AQvEnDBCP6hUT7ga2Mekgm5uSk8+Hnba/npp+YOY90kAb+MqE2l82/AOU4Mh?=
 =?us-ascii?q?IBX2mH9eig2rDu5lD5T6lQjvEsjKbWrY3aKdwBpqGlGw9Vzpoj6xGnAjei0d?=
 =?us-ascii?q?QYm2QHLV1cdBKEkYfpIVfOL+78DfqknVSsnylkx+rcMr3iHJrNNH7Dn6nlfb?=
 =?us-ascii?q?pn7E5c0gUznphj4MdeELYGJvP+ckvwstXCCVk+KQPwi+LmDshtk4ATQ2SCBo?=
 =?us-ascii?q?eHP67I91yF/OQiJ6+LfoBR8AT9Kuk44bbXjHY/0QsPfai4wJ0OQHujWOltOQ?=
 =?us-ascii?q?OUbWe6xp8qEWoMsRsjBNftjlLKBTVIYHC9d6knoCwwEsSrAZqVFa63h7nU7S?=
 =?us-ascii?q?apHoBRLlJGA1HERWb6d4yFA69XQD+ZOIlsniFSBuvpcJMoyRz77Fyy8LFgNO?=
 =?us-ascii?q?eBv3RA7Z8=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2HgAgAO0ZZdh0anVdFlDoVtM4RMjl6?=
 =?us-ascii?q?FFwGYGAEIAQEBDi8BAYQ7A4JKIzgTAgMJAQEFAQEBAQEFBAEBAhABAQEIDQk?=
 =?us-ascii?q?IKYVAgjopAYNVEXwPAiYCJBIBBQEiATSDAIILoV6BAzyLJoEyiGUBCQ2BSBJ?=
 =?us-ascii?q?6KIwOgheDbnOHUYJYBIE3AQEBlSuWUgEGAoIRFAOMUYhEG4IqlxaOK5lKDyO?=
 =?us-ascii?q?BRoF7MxolfwZngU9PEBSBaY1xWySRewEB?=
X-IPAS-Result: =?us-ascii?q?A2HgAgAO0ZZdh0anVdFlDoVtM4RMjl6FFwGYGAEIAQEBD?=
 =?us-ascii?q?i8BAYQ7A4JKIzgTAgMJAQEFAQEBAQEFBAEBAhABAQEIDQkIKYVAgjopAYNVE?=
 =?us-ascii?q?XwPAiYCJBIBBQEiATSDAIILoV6BAzyLJoEyiGUBCQ2BSBJ6KIwOgheDbnOHU?=
 =?us-ascii?q?YJYBIE3AQEBlSuWUgEGAoIRFAOMUYhEG4IqlxaOK5lKDyOBRoF7MxolfwZng?=
 =?us-ascii?q?U9PEBSBaY1xWySRewEB?=
X-IronPort-AV: E=Sophos;i="5.67,254,1566889200"; 
   d="scan'208";a="12717310"
Received: from mail-lf1-f70.google.com ([209.85.167.70])
  by smtp2.ucr.edu with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 03 Oct 2019 21:59:25 -0700
Received: by mail-lf1-f70.google.com with SMTP id c83so590565lfg.8
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2019 21:59:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=/wqlFjZWCjCPveRZJCwZsiQPobPTNxdUjDyqHnCz4F4=;
        b=fvVeovoPpEp3V85jhZvsLpMj4YRdEVLOMgCiNU/zmP1uT60ZdOawsSZd69Le4HJmOg
         j0nOOdmIK50oy+BCRq5Z3HVgg+w5fD/yli7bWALpVWLBBewQjqjGuxrPMROg7hRsFIYT
         FZZEJnE71D0FAlcA4rE19LA3IvPV9RUgoROmLxgheUOKQqxxjLd/5jS8qQX2PMF7EzWo
         xIkZKUhvMLNa5sD8GQGZeh3dDeTL7VnYihpk1CDz+PKF3OSKcKQZMQi9vyi+4jSkTlue
         z0HAZRAOvVQHD3TzAc8v3u4YRVbT0lXdshp/Mbph5RfnyuMPO5NSG9xYH1vKt4V71YK7
         sPAQ==
X-Gm-Message-State: APjAAAUlXaWmNp1kGym8xXWRywFee/wsVAceyvaW3pqbYdpSP1lfcMpG
        Q+lOw3J6kDgeriVD5xTKS37eRq0V1gQNFssHAkQ0wphry64iVSC/v4Gy/OeRAOQ8l+qgHnYiBnl
        Vedb1ICi64UBgfQg+wffe9QVHHFls+2jqOXSFU+5+Kw==
X-Received: by 2002:ac2:44d2:: with SMTP id d18mr8014909lfm.67.1570165163579;
        Thu, 03 Oct 2019 21:59:23 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzf/fx+fVC1so2XwnCDn2l3vRm27QwdUqRpMOpcPIChmwjfp3XzFNqgvVyNhnF3oIXiNrhVZGQSuDVdz5I1IOk=
X-Received: by 2002:ac2:44d2:: with SMTP id d18mr8014903lfm.67.1570165163388;
 Thu, 03 Oct 2019 21:59:23 -0700 (PDT)
MIME-Version: 1.0
From:   Yizhuo Zhai <yzhai003@ucr.edu>
Date:   Thu, 3 Oct 2019 21:59:10 -0700
Message-ID: <CABvMjLRCVSNz6nn7pY2bS=-ViJ7FNz_5nt28CDEJQxtRmb-1Rg@mail.gmail.com>
Subject: Potential uninitialized variables in regulator: ltc3589
To:     broonie@linaro.org, linux-kernel@vger.kernel.org,
        Zhiyun Qian <zhiyunq@cs.ucr.edu>,
        Chengyu Song <csong@cs.ucr.edu>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All:

drivers/regulator/ltc3589.c

Variable "irqstat" in function ltc3589_isr() could be uninitialized if
regmap_read() returns -EINVAL. But it's directly used later without
the return check, which is potentially unsafe.

Also, we cannot simply return -EINVAL in ltc3589_isr() because
the error code is out of the return type: irqreturn_t.

Thanks for your time to check this case.

-- 
Kind Regards,

Yizhuo Zhai

Computer Science, Graduate Student
University of California, Riverside
