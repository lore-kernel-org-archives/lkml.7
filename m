Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69660C47404
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 19:18:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 447952133F
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 19:18:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ucr.edu header.i=@ucr.edu header.b="qAlBVLaB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729123AbfJGTSb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 15:18:31 -0400
Received: from mx1.ucr.edu ([138.23.248.2]:24237 "EHLO mx1.ucr.edu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728187AbfJGTSb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 15:18:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=ucr.edu; i=@ucr.edu; q=dns/txt; s=selector3;
  t=1570475912; x=1602011912;
  h=mime-version:from:date:message-id:subject:to;
  bh=LHYtmlTgSx58sSJEN4Ghrk7oWWL9DzXHOlkqjGOMe2E=;
  b=qAlBVLaBUyyI4AISZoNvLT1/fIEuDpCTTWsaTwhqB2TU9clI8BIpzZU5
   Z9s/nLgQyOIURB2/XJeTD10WkSAlpEpbCsdKCESahrlXOqgEDXu3sfqnl
   Ls/aLc/VZq9oIjq6dg0XYy3JkmnvOHF164bLpZAk5y4avfawiySXmHT9e
   LP2m2zRR0eAOzY3x/UBQJkrnWzoWcbTaaoKC88e2Z14v7J1Q+JRVmbdth
   4SWDqu3gpyoqOp5jByLFb2A59v652sU/8lT5m6Nm2gczUTWsPT2iNkHGp
   ARK43NVTJBTBZS34hXYyaq9ok2prP0VGVsZq4+BRWwSoe81kZqoGE9t57
   Q==;
IronPort-SDR: XHGjI/59+skFBdtACwmX64GaKi3MeIV6fZfxqoBmmLNDJUM3L1G63Rhfnzf7YoGWrarn6Q3w3a
 cNa89zhNs6pijosgMWbTmSp0UGIH+SACmqt8BsrDOSLXJ/4DWs2uiouYO+6qiDH04glJN/z4cE
 7ZwjNUAmlWTa4nTKcbbbbmATO36wESIRxH0TxIBuxvkncaphclaupwpNWMtj10Fdu6gDEjtNc5
 WOfBFxv3tSpeAL5uDdK4d+O1VjaOYGzLJUCUlfMniWIvK83/V6jif7dGOG5xaJwpaoxjI56jJ2
 csc=
IronPort-PHdr: =?us-ascii?q?9a23=3A7XpqoRT7PhRMhugS5p6Jn9x7k9psv+yvbD5Q0Y?=
 =?us-ascii?q?Iujvd0So/mwa67ZhaOt8tkgFKBZ4jH8fUM07OQ7/m7HzFfqs/b6TgrS99lb1?=
 =?us-ascii?q?c9k8IYnggtUoauKHbQC7rUVRE8B9lIT1R//nu2YgB/Ecf6YEDO8DXptWZBUh?=
 =?us-ascii?q?rwOhBoKevrB4Xck9q41/yo+53Ufg5EmCexbal9IRmrowjdrMkbjIltJqos1B?=
 =?us-ascii?q?fFv2ZDdvhLy29vOV+dhQv36N2q/J5k/SRQuvYh+NBFXK7nYak2TqFWASo/PW?=
 =?us-ascii?q?wt68LlqRfMTQ2U5nsBSWoWiQZHAxLE7B7hQJj8tDbxu/dn1ymbOc32Sq00WS?=
 =?us-ascii?q?in4qx2RhLklDsLOjgk+2zMlMd+kLxUrw6gpxxnwo7bfoeVNOZlfqjAed8WXH?=
 =?us-ascii?q?dNUtpNWyBEBI63cokBAPcbPetAoIbzp1UAoxijCweyGOzi0SNIimPs0KEmz+?=
 =?us-ascii?q?gtDQPL0Qo9FNwOqnTUq9D1Ob8QXuC0zajIzSjDb/RL0jj+6IjHaBEhquyLUL?=
 =?us-ascii?q?NwcMvRyVMgFwLZglmMp4HoJC6V2fgXs2SB8eVvSP+vhnchpgpsoTav3t8hhp?=
 =?us-ascii?q?fVio8R0FzJ9iV0zJwrKdGkS0N3e8OoHZ9SuiycKoB4WNktQ3tytyY/0rAGvJ?=
 =?us-ascii?q?m7czUUx5k/3B7fbuCHc5CP4hL+SOadOTd4i2xheLK4nxuy9FKvyuz4VsWt1F?=
 =?us-ascii?q?ZKrDdJnsDCtnwQ0xHe6NKLSvR6/kem1jaP0x7c5vtYLkAzkKrXM58hwrgumZ?=
 =?us-ascii?q?oPqUnPADP6lUHsgKKVdkgo4Pak5/jkb7n8u5ORM415hhn7Mqs0m8y/Beo4Mh?=
 =?us-ascii?q?IJX2ie4em91Lzi/U3jT7VLkvE6jqfUvYvHJcsHvK61GRFa3Zs+6xqnFTepzM?=
 =?us-ascii?q?wYnWUbLFJCYB+Hi4npO1fTIPH3FPu/gEqjkC1tx//YOr3sGYvNLnfdn7f7Z7?=
 =?us-ascii?q?p96FBTyBA1zd9B45JYELYBIOj8Why5iNuNLBg5Ogqyzv2vIthn2ctKW2WPC6?=
 =?us-ascii?q?mfPbiUu1KS6couJfWBYMkevzOrb7AI4vvni2I0nRcyZ7Ss15IcaDjsE/FjKk?=
 =?us-ascii?q?OEbH6qjc0cFG0DtQoWTer2hVnEWjlWMTL6e78373kQD4+iDYCLEoSwi72I2i?=
 =?us-ascii?q?D9FZpbYmBBIlGKDXrsMY6DXqFIIAOUPsJl2hgFU6WxA7AgzxyquRThg+5jL+?=
 =?us-ascii?q?zJ6jIZu5PL1d5p6umVnhY3o3g8LM2Z12zFcWhwmStcRCE/2KdXqktxx16ey6?=
 =?us-ascii?q?9iirpfD9MFo7tgQw4+PNb2wu93EZimUxPIet7PQlulT8+OADctQ9Z3yNgLNQ?=
 =?us-ascii?q?I1INWrjhnZlxHiJrYJlqCaDZwpuvbH33HxLtw70DDD3bUgk0gvQtZnNGu6i6?=
 =?us-ascii?q?o5/A/WUcqBqEyDnu6Rda0G2yiFoHyK12PIp0FRSgl2eaTDQX0bIEDRqIK9rk?=
 =?us-ascii?q?fDSaK+TKsmKAZFxNWZArVFZ8evjlhcQvrnftPEbCb5nWqsCRuW7q2DYZCseG?=
 =?us-ascii?q?gH2ijZTk8enERb+XeAKBh7BSq7pW/aJCJhGEipYE729+R67nShQQt8/QGLfl?=
 =?us-ascii?q?Bnn4O08xhd0e6cSuIO2Kssszxntj5uWluxwoSSQ/GAqgxubbgUWtQ77x8T3n?=
 =?us-ascii?q?nesQNVNYfmMqt4wFMSblIkkVnp0kBGC5dAjM9innMjzUImOLCY2VIZL2iwwJ?=
 =?us-ascii?q?vqfLDbNz+hr1iUd6fK1wSGg56t8aAV5aF98g27sQ=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2FkAgB6jptdh8XQVdFmDhABBhKFd4R?=
 =?us-ascii?q?NjmCFFwGMUIEYijQBCAEBAQ4vAQGHHyM4EwIDCQEBBQEBAQEBBQQBAQIQAQE?=
 =?us-ascii?q?BCA0JCCmFQII6KQGDVRF8DwImAiQSAQUBIgE0gwCCC6JzgQM8iyaBMoQLAQG?=
 =?us-ascii?q?EVgEJDYFIEnoojA6CF4ERg1CHUYJYBIE4AQEBlSyWVAEGAoIQFIxUiEQbgio?=
 =?us-ascii?q?BlxSOLJlLDyOBRoF7MxolfwZngU9PEBSBaY1xBAFWJJIcAQE?=
X-IPAS-Result: =?us-ascii?q?A2FkAgB6jptdh8XQVdFmDhABBhKFd4RNjmCFFwGMUIEYi?=
 =?us-ascii?q?jQBCAEBAQ4vAQGHHyM4EwIDCQEBBQEBAQEBBQQBAQIQAQEBCA0JCCmFQII6K?=
 =?us-ascii?q?QGDVRF8DwImAiQSAQUBIgE0gwCCC6JzgQM8iyaBMoQLAQGEVgEJDYFIEnooj?=
 =?us-ascii?q?A6CF4ERg1CHUYJYBIE4AQEBlSyWVAEGAoIQFIxUiEQbgioBlxSOLJlLDyOBR?=
 =?us-ascii?q?oF7MxolfwZngU9PEBSBaY1xBAFWJJIcAQE?=
X-IronPort-AV: E=Sophos;i="5.67,269,1566889200"; 
   d="scan'208";a="12737843"
Received: from mail-lj1-f197.google.com ([209.85.208.197])
  by smtp1.ucr.edu with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 07 Oct 2019 12:18:31 -0700
Received: by mail-lj1-f197.google.com with SMTP id g88so3800238lje.10
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2019 12:18:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=HOvGdjzdmR9zNG6ZkfBcEllkGY6GoUXzSDLht1mF2WI=;
        b=Xcfop3PGtkU2EhaXPnXcscVG2oi0B+hWFuG18Cuc3JD73stHyb9g5ogtgbO5JkMIiS
         jy//N9/ukaKlTnbWP/RN1KIytOm2tU8PQ/d2sfxICLdZzR30KlO/SpCsaXJ9YM3UlzUT
         ydAgbNGXF2estdEXWSadmk0JK9JsBg1yFvwUrKJobZhHB1dW/TLUJrwCJGYCp54/N/qX
         Zzq3+IXvWfnZp5R2UuBzQTl/VkcSbi7JgLh7O1LbWIUlgoFFWGzOJFsIEP/erxygTR2g
         /HWk1BakUCPL49s8PhZyY8yWoNWtMHeUOHOuSUryYXMs7nw8HwSzwNyAgey4GNXXllcg
         YYhA==
X-Gm-Message-State: APjAAAVXBVinQPaUSS00V4Mut20Qo53QPGBDRhiuvoXYvVs6bw1zFcyj
        zsEBr4xQQbNdDWcreH+gqexkk+69B4jb8Jfb9USBIS4pNWxlmLMhC1BcYvuPmw1/CJVoqFZCzPY
        qOebsJa2wmFTpWekxm7CaC+bg4gf6hCTSfgWLqSDuUA==
X-Received: by 2002:ac2:44d2:: with SMTP id d18mr18369573lfm.67.1570475908314;
        Mon, 07 Oct 2019 12:18:28 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzDsm2ohzARraL1dLP+2VP0TkKPuqHmWeU4s0nw0vbJHVPGul4JY6lCMGPAe2OrCXzu0/jcM+Elf0wRZoMMQ8w=
X-Received: by 2002:ac2:44d2:: with SMTP id d18mr18369560lfm.67.1570475908124;
 Mon, 07 Oct 2019 12:18:28 -0700 (PDT)
MIME-Version: 1.0
From:   Yizhuo Zhai <yzhai003@ucr.edu>
Date:   Mon, 7 Oct 2019 12:19:11 -0700
Message-ID: <CABvMjLRhqCAs-r3LA4nX_5tBj=hQeUfb4g5gHf8ghRdwWqKuPA@mail.gmail.com>
Subject: Potential NULL pointer deference in iwlwifi: mvm
To:     Johannes Berg <johannes.berg@intel.com>,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>,
        Intel Linux Wireless <linuxwifi@intel.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Ayala Beker <ayala.beker@intel.com>,
        Shahar S Matityahu <shahar.s.matityahu@intel.com>,
        Sara Sharon <sara.sharon@intel.com>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Zhiyun Qian <zhiyunq@cs.ucr.edu>,
        Chengyu Song <csong@cs.ucr.edu>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All:

drivers/net/wireless/intel/iwlwifi/mvm/scan.c:

Inside function iwl_mvm_power_ps_disabled_iterator(),
iwl_mvm_vif_from_mac80211()
could return NULL,however, the return value of
iwl_mvm_vif_from_mac80211() is not checked and get
used. This could potentially be unsafe.

-- 
Kind Regards,

Yizhuo Zhai

Computer Science, Graduate Student
University of California, Riverside
