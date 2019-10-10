Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07BE2C10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 05:03:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9555208C3
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 05:03:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ucr.edu header.i=@ucr.edu header.b="JOv7jbmP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731917AbfJJFDN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 01:03:13 -0400
Received: from mx6.ucr.edu ([138.23.62.71]:4896 "EHLO mx6.ucr.edu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727856AbfJJFDM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 01:03:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=ucr.edu; i=@ucr.edu; q=dns/txt; s=selector3;
  t=1570683793; x=1602219793;
  h=mime-version:from:date:message-id:subject:to;
  bh=JCsL3WIN73xzwLhXOrKo3QlppAA/heL7UqOSuoxaqtM=;
  b=JOv7jbmPKDdgM50iVtT6t6wnGGU4HabVfP+AG9D3SE/kPSHerbccAiu4
   f2IrwexOyvbR9Hp6HcKzsgmg57wq8KUEOe7eO07jIdvus06SGuMbWYbVz
   ArVkM3gq9fhW0mztul1alh1Ihbw4d6C1RrFCcRoav8Zl/lvG6dVeyIvyt
   GohcE9Gpnrd+7/BWmB/tlD8WN7JnlGGwKYdrMvAlug2uz9zQL1gfucF3/
   MsfN5Z/YK3BcGM9bvurWkQsTqyzCDDqRDH2BJoQFmD2KoQMqreAwr+PJk
   OAByZwSGJpFVig949/LDHq0BZebtBN5OWcm8KdwdzlGpPj+eDKo71/vXg
   g==;
IronPort-SDR: tvyOjakpVFiZiDacPjztNdydUk+608RGytbBi0LM88Xg5GN0rWzJtn4mg6FgfC3JzdcnUu/GUW
 J4M9WG4K3RjoOlyenuAdkn+ZpJgodec398GJOjgPQw76SkfoAMdCdW4+Om0L94N672llMufS1p
 mbIWj7MBHVRuROSMmaoac4tvpihePs5MpCAdPHdmkvwZsbpOaJcKsA2Jvv3C8Q2/Q5+jGIJeJm
 hnfDTC9ewogTx5yXXJtwYj2rpXVd6vllhgkDTVXNQTe1JCHOwsIZ5+obfgStEEOAqc8b28ke17
 aW0=
IronPort-PHdr: =?us-ascii?q?9a23=3AOa0FmxH3JfDpAXjSt0LflZ1GYnF86YWxBRYc79?=
 =?us-ascii?q?8ds5kLTJ76psmzbnLW6fgltlLVR4KTs6sC17ON9f66Ej1Zqb+681k6OKRWUB?=
 =?us-ascii?q?EEjchE1ycBO+WiTXPBEfjxciYhF95DXlI2t1uyMExSBdqsLwaK+i764jEdAA?=
 =?us-ascii?q?jwOhRoLerpBIHSk9631+ev8JHPfglEnjWwba58IRmsrAjdqMYajI9/Jq0s1h?=
 =?us-ascii?q?bHv3xEdvhMy2h1P1yThRH85smx/J5n7Stdvu8q+tBDX6vnYak2VKRUAzs6PW?=
 =?us-ascii?q?874s3rrgTDQhCU5nQASGUWkwFHDBbD4RrnQ5r+qCr6tu562CmHIc37SK0/VD?=
 =?us-ascii?q?q+46t3ThLjlTwKPCAl/m7JlsNwjbpboBO/qBx5347Ue5yeOP5ncq/AYd8WWW?=
 =?us-ascii?q?9NU8BMXCJDH4y8dZMCAOUBM+hWrIfzukUAogelCAmwGO/i0CNEimPq0aA41e?=
 =?us-ascii?q?kqDAHI3BYnH9ILqHnbrtT1NaYSUeCoy6nD0DbMb/NM1jf89YPFdRAgoPCMXb?=
 =?us-ascii?q?1qcMrd1VUjGg3eg1WNtYPlJSmZ2foQvGiG9udtU/+khW0/qwxpvDSj2sMhhp?=
 =?us-ascii?q?PKi48V0FzI6CR0zYQvKdC6VEJ2Z8OvHoFKuCGALYR2R9svQ2RvuCkn1LILoY?=
 =?us-ascii?q?W7fC0WyJQ/wB7fduCHf5CI4h39UOaRJi91hHd/d7K+gxa+6EygyuPhWsWt3l?=
 =?us-ascii?q?ZHrDZJnsPDtnAK0BzT5cyHReVn8ki93jaP0hjf6uBCIU8qiarWM4AtzqI0m5?=
 =?us-ascii?q?YJsknOHjX6lFj3gaKUbEkp+PSk5/ziYrr8p5+cM4F0ihv5MqQrgsG+AeU5Mg?=
 =?us-ascii?q?gUUGia5eiwyLPu8FbkQLpWlP06iLfWv43HJcgDvK62HxdV0po/6xa4Fzqm1N?=
 =?us-ascii?q?UYnX8aLFNKYR6HjJbmO0vIIP/mCfeymEqskDh1yPDcJLHhAYvCLmLFkLj/eb?=
 =?us-ascii?q?Zx8UlcyBA8zYMX25UBKLYBKfT1V1S5ntHCAVdtMQu0yuDhBc473I4EVkqOBL?=
 =?us-ascii?q?OUNOXZtlreoqoCJuyFYpIYvH7SMeUg7ffljTdtlFoYdK+00J9RZ2qlG/5vKE?=
 =?us-ascii?q?WxYHzwj9NHGmAP6E52aPHhgRWpVjNXZ3H6C6Yh7TAyDoXgBoDOQoCqqL2HwC?=
 =?us-ascii?q?q/WJZRYzYCQnGKDXrsP6GFXeocIB2TOMJlnycfHeylSok8xQ6vug7Syrx7I+?=
 =?us-ascii?q?6S8Sod49ar99Fx4+Cbqxg28nQgDNqU12alRGZ4k2oVXTgs1eZ4u0Mrjh/J/a?=
 =?us-ascii?q?FmgvAQLpobwvJNVgogf9aIw+VkBtXaVgvfc9KNT1i6BNOrHWd1BvsvwtAHYk?=
 =?us-ascii?q?I1NM+jiAvf0iusS+scib2EDZ0wtK3G3n7qO8t8zV7H0rUsix8tRc4ZcSWGj6?=
 =?us-ascii?q?96vyTJCp/Hjl6C3/KqfKUZmiLX+XaN0HGVlEBeTAN0F67CWCZbLk/Xq8npo1?=
 =?us-ascii?q?zDVbKqBK88GhVOxNTEKaZQbNDty1JcS7OrPtnCb2+vs3m/CAzOxb6WaofuPW?=
 =?us-ascii?q?IH02GVDEkCjhBW/nucMwU6LjmurniYDzF0E1/rJUT2/rpQsnS+G3413QGXaA?=
 =?us-ascii?q?VT17O0skoEl/yVSqtLhZoZsz1npjlpSgXul+nKAsaN8lIyNJ5XZskwtRIejT?=
 =?us-ascii?q?rU?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2E1AwB/up5dgEanVdFlhlKETY5bhRc?=
 =?us-ascii?q?BmB0BCAEBAQ4vAQGHGCM4EwIDCQEBBQEBAQEBBQQBAQIQAQEJDQkIJ4VCgjo?=
 =?us-ascii?q?pAYNVEXwPAiYCJBIBBQEiATSFeAWkPYEDPIsmgTKEDAGEWAEJDYFIEnoojA6?=
 =?us-ascii?q?CF4ERg1CEKIMqgl4EgTkBAQGVL5ZXAQYCghAUjFSIRRuCKpcWji2ZTw8jgUa?=
 =?us-ascii?q?BezMaJX8GZ4FPTxAUj14BViSRSwEB?=
X-IPAS-Result: =?us-ascii?q?A2E1AwB/up5dgEanVdFlhlKETY5bhRcBmB0BCAEBAQ4vA?=
 =?us-ascii?q?QGHGCM4EwIDCQEBBQEBAQEBBQQBAQIQAQEJDQkIJ4VCgjopAYNVEXwPAiYCJ?=
 =?us-ascii?q?BIBBQEiATSFeAWkPYEDPIsmgTKEDAGEWAEJDYFIEnoojA6CF4ERg1CEKIMqg?=
 =?us-ascii?q?l4EgTkBAQGVL5ZXAQYCghAUjFSIRRuCKpcWji2ZTw8jgUaBezMaJX8GZ4FPT?=
 =?us-ascii?q?xAUj14BViSRSwEB?=
X-IronPort-AV: E=Sophos;i="5.67,278,1566889200"; 
   d="scan'208";a="81372901"
Received: from mail-lf1-f70.google.com ([209.85.167.70])
  by smtpmx6.ucr.edu with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 09 Oct 2019 22:03:12 -0700
Received: by mail-lf1-f70.google.com with SMTP id m17so1050081lfl.11
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2019 22:03:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=6pAAPXZ1XbspBXsT/nVNYN754RlatzoTXF5DnMyqcQU=;
        b=lC086okWEqEhkQJ65+Eetd1F39PJmJcHk0T6iS+bgwWd7U0tkaKGDMza5ZCHgr8FN+
         Ui5vXNSsyfj3q6w0xQea2NcHjCtH8StFqZ+BnIpC+N4ijPa5K/11RczDPfQB5Xx/yEbG
         41QGyEXwFkZ9PAmkSt+8gaQDHa87kVnLh7Xs/1E3dLR8BXcBY5IrHZGjELO2icE3BbwD
         FD3eXtO98phlvvC6WEq6k8lj5NW56YWKNZnbYwYe/lgBm8Ca8ccNJS9uzvkllByUC6H5
         5mtLKhbAW4UaoSJrlpZVtkHrkjrFrL0pUvtn4JBaEEWbqtc+kqbQajiuGmb2yG4PPxTa
         aipA==
X-Gm-Message-State: APjAAAW6XEeQ62g2qEPTYXWVGs+EtEK7PEDd/LEFu7pqWThD4V0QZ89I
        NzdQPBjEoYhAFnqqNS6+F6dokTcmTayFfDCZmphoJ1abKx5lL2Wam2YQxpwbIRvrVYo2YPv7NdD
        Tdiagq00b+6JfVpOYi6AUnZdiGLHAgYBoFRKJ5y8EYg==
X-Received: by 2002:a2e:9a4e:: with SMTP id k14mr4816416ljj.104.1570683789473;
        Wed, 09 Oct 2019 22:03:09 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyLbyF0nKrTc3N1NhrBYGj51/xn4jBAjuUiVfEPkbcB6vQTEAA65Ud8oPAk9dQ6WUgeoAyg9+sMf/8vTtEysGQ=
X-Received: by 2002:a2e:9a4e:: with SMTP id k14mr4816390ljj.104.1570683789247;
 Wed, 09 Oct 2019 22:03:09 -0700 (PDT)
MIME-Version: 1.0
From:   Yizhuo Zhai <yzhai003@ucr.edu>
Date:   Wed, 9 Oct 2019 22:02:43 -0700
Message-ID: <CABvMjLThWpQYir0soRDE3W4S6q0S28RTxen8Y-2YAxbRczMCiA@mail.gmail.com>
Subject: Potential NULL pointer deference in iwlwifi: mvm
To:     Johannes Berg <johannes.berg@intel.com>,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>,
        Intel Linux Wireless <linuxwifi@intel.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        "David S. Miller" <davem@davemloft.net>,
        Avigail Grinstein <avigail.grinstein@intel.com>,
        Haim Dreyfuss <haim.dreyfuss@intel.com>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All:

drivers/net/wireless/intel/iwlwifi/mvm/power.c:

The function iwl_mvm_vif_from_mac80211() could return NULL,
but some callers in this file does not check the return value while
directly dereference it, which seems potentially unsafe.
Such callers include iwl_mvm_update_d0i3_power_mode(),
iwl_mvm_power_configure_uapsd(),
iwl_mvm_power_allow_uapsd(), etc.



-- 
Kind Regards,

Yizhuo Zhai

Computer Science, Graduate Student
University of California, Riverside
