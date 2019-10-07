Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD231C47404
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 19:14:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D356206C2
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 19:14:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ucr.edu header.i=@ucr.edu header.b="aYvISMBI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728860AbfJGTN5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 15:13:57 -0400
Received: from mx2.ucr.edu ([138.23.62.3]:19832 "EHLO mx2.ucr.edu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728116AbfJGTN5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 15:13:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=ucr.edu; i=@ucr.edu; q=dns/txt; s=selector3;
  t=1570475636; x=1602011636;
  h=mime-version:from:date:message-id:subject:to;
  bh=dallgVAkyTK9hhgH9V6Aj3NUK6xmHY7JKRhH0QVlX3E=;
  b=aYvISMBIjVcAFDeNtCrBLzt3BIVgJX4neGnksVDZNgGUmsZA8BbwUWEm
   ioTOMFFVZz6LnhE1Gj/7TXqX5G0/YWMxR945uMTnjfwCkTi6azLOMdO6U
   6FHeJaamU38JY2UgBsWi75Zvrilrr0Zag6YS4tmtz1mZbAkyI+uTFJV3A
   zHF/Zy3/rX+I+tFxfat7qPW6r5eKK0uMpnMXd57LWm5FDP4NkWnS1FikC
   90goRmYiMARhpWHCUZG3akPUXQQ8abnneGO5xQfgT/5j8wgvmGsbBdRo/
   yHa4l3V09RPxRP9gX4kl/RTdVcwBk3jeAlkHP0XukRUEINwYdpitqkZce
   g==;
IronPort-SDR: yz1j7lCEwiVaqTP5yExWPsJuPJp9Q3/NNRuA71sq/tI3q6FbuJPeAVhf9AhehUc+xqfkQnaub2
 ckg95AOMqnlmoJZnNxZhGpUdXWzvVbwZSR/C31TsytU701We3zvI6oikpb8njAx3raewdI3XnC
 gtF1cWNV0WU8HjAXmXYEmQj71bRZddTQY0dw9DIWyWuPtGNOk0qYvMSC38gut437BYQN447SHq
 pR1ISSK/IRsfQJtkMqKtwR6DN8Y5dWeULV460W0uFg7ht/PuzhTQwGqM+sOET3k3ig/h29wSZk
 7RA=
IronPort-PHdr: =?us-ascii?q?9a23=3A+CUvZh0mNFOEe4uosmDT+DRfVm0co7zxezQtwd?=
 =?us-ascii?q?8ZsesXIvTxwZ3uMQTl6Ol3ixeRBMOHsqkC1rWd6vq5EUU7or+5+EgYd5JNUx?=
 =?us-ascii?q?JXwe43pCcHRPC/NEvgMfTxZDY7FskRHHVs/nW8LFQHUJ2mPw6arXK99yMdFQ?=
 =?us-ascii?q?viPgRpOOv1BpTSj8Oq3Oyu5pHfeQpFiCezbL9oLBi7rwrdutQIjYd/N6081g?=
 =?us-ascii?q?bHrnxUdupM2GhmP0iTnxHy5sex+J5s7SFdsO8/+sBDTKv3Yb02QaRXAzo6PW?=
 =?us-ascii?q?814tbrtQTYQguU+nQcSGQWnQFWDAXD8Rr3Q43+sir+tup6xSmaIcj7Rq06VD?=
 =?us-ascii?q?i+86tmTgLjhTwZPDAl7m7Yls1wjLpaoB2/oRx/35XUa5yROPZnY6/RYc8WSW?=
 =?us-ascii?q?9HU81MVSJOH5m8YpMAAOQBM+hWrJTzqUUSohalGQmgGPnixiNUinPq36A31f?=
 =?us-ascii?q?kqHwHc3AwnGtIDqHbbrNT0NacSTOC1y7TDwjbDb/xM2Df29Y/FcxAgoPGMR7?=
 =?us-ascii?q?1wcNbdxVUhGg7ek1WftZblMymL2esQrmiW9uxtXv+shW4/swx9vCSjy8M2ho?=
 =?us-ascii?q?TKho8Z0E3I+CR7zYovJ9C0VUh2asO+HpRKrSGVLY52T9snQ2FvpSk11KULuY?=
 =?us-ascii?q?W+fCgW0JQnwAPfa+Cff4iI/B3jUOGRLC99hH1/ebK/gw++8UyuyuHhT8W03l?=
 =?us-ascii?q?RHojdfntnDsXAN0BPT6syZRfdn4kih3jOP2xjS6uFCP080ibLWJ4A9zrM0jJ?=
 =?us-ascii?q?YeskTOEjXrlEj3jqKabEcp9vWw5+TieLrmp5ucN4FuigH5N6Qjgsy+AOU4Mg?=
 =?us-ascii?q?cUXmiX5fiw2bP48E3kXLpKlOc6nbfEv5DHPcgbvLK2AxdJ0oY/7BayFzOm0N?=
 =?us-ascii?q?UenXkaI1NJYRGHgJbzO1HIPv/4Ceyyg0qjkDh13fDKJL7hDYvXLnjFjrjhea?=
 =?us-ascii?q?xx60lGyAo8nphj4Md2DbEIJvT+QQfbucbXRks7NAy9xeDqE5N325kRcWOJHq?=
 =?us-ascii?q?KddqjVtAnMrs8qJuCKeYIR8BnnNv0v7vXuxSs0nFoUe7Sk2d0Ycm29FP1tI2?=
 =?us-ascii?q?2YZ2bhhpEKFmJc+kIaUefjwHaFXDpTYD7mW7835zg9D8StCorHRoeFgbqd0S?=
 =?us-ascii?q?P9FZpTMCQOK1aQHHOgU4SCRudEVyOIL8tsiSdMAbygTZIxyhCgtSf7zaZqKq?=
 =?us-ascii?q?zf/ShO8drA3dxx6qXtnBU1vWh3Ec2Z1EmGSG15l34SQCU/mqdlrho5gneK0K?=
 =?us-ascii?q?0wr+ZVBNJO/OgBBgczNJuaw/Z3Gt7vQRnpf9GVRVLgSdKjV3V5Z8wwzNYPZw?=
 =?us-ascii?q?5SAdSklQzO3iziV7YLlrOCBZhy/bjd2WPtKsd743fAyKQlyVIhR50LfWmngL?=
 =?us-ascii?q?NvshfSHYPNnl6Cv7ileL5a3yPX8mqHi22UswUQVgNsXajbdW4Qa1GQrtnj4E?=
 =?us-ascii?q?7GCbi0BvBvNgpH1N7HKaZQbNDtpUtJSe2lO9nEZW+13WCqClLA9LONfZfsM1?=
 =?us-ascii?q?wc1SOVXFoEkhEO+2+uPhN4Gyy75W/SEWoqXXnvbkXj4PQ2k3S9QQdgxBqNaU?=
 =?us-ascii?q?JJ3KHz5xUPw/GQVqVA8KgDvXIQqid0AVH17dLfCpLUthhhdaQEOYgV/Vxdk2?=
 =?us-ascii?q?/VqloubdSbM6l+iwtGIExMtET02kAyU90YnA=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2FmAgBJjZtdhkenVdFmDoYghE2OYYF?=
 =?us-ascii?q?tBYMlAYxQgRiKNAEIAQEBDi8BAYcfIzgTAgMJAQEFAQEBAQEFBAEBAhABAQE?=
 =?us-ascii?q?ICwsIKYVAgjopAYNVEXwPAiYCJBIBBQEiARoagwCCC6JqgQM8iyaBMoQLAQG?=
 =?us-ascii?q?EVgEJDYFIEnoojA6CF4ERgmSFFIMpglgEgTgBAQGVLJZUAQYCghAUjFSIRBu?=
 =?us-ascii?q?CKgGXFI4smUsPI4FGgXszGiV/BmeBT08QFIFpjXEEAVYkkhwBAQ?=
X-IPAS-Result: =?us-ascii?q?A2FmAgBJjZtdhkenVdFmDoYghE2OYYFtBYMlAYxQgRiKN?=
 =?us-ascii?q?AEIAQEBDi8BAYcfIzgTAgMJAQEFAQEBAQEFBAEBAhABAQEICwsIKYVAgjopA?=
 =?us-ascii?q?YNVEXwPAiYCJBIBBQEiARoagwCCC6JqgQM8iyaBMoQLAQGEVgEJDYFIEnooj?=
 =?us-ascii?q?A6CF4ERgmSFFIMpglgEgTgBAQGVLJZUAQYCghAUjFSIRBuCKgGXFI4smUsPI?=
 =?us-ascii?q?4FGgXszGiV/BmeBT08QFIFpjXEEAVYkkhwBAQ?=
X-IronPort-AV: E=Sophos;i="5.67,269,1566889200"; 
   d="scan'208";a="13364168"
Received: from mail-lf1-f71.google.com ([209.85.167.71])
  by smtp2.ucr.edu with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 07 Oct 2019 12:13:55 -0700
Received: by mail-lf1-f71.google.com with SMTP id q3so1672461lfc.5
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2019 12:13:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=PJAtcYhKUx1R52oEkTsXsXK1JI9Wj7XIccCM13DifW8=;
        b=U11APYlcAEerxxJ2E9ABCk1tbsITETzGXSmSRI73ZBOgPcDZEAf6qo8lASEU4hWsAQ
         ubR3G4V6UeVet67bxvw6MDC5TJ2NJp0AJZZWAog8fsZ+GIoi894jDmTOkUaVV8i1BAS9
         Fzy6lR8h7cOo9AV1rueFKFUbxlOcsDouWO0B+qRsVw8SqCiFVFhNQsaBQn2RqEj1udqT
         iyO1mr+vfwDBTFVeD7pucnr0/j0zJLykE6xRvFZRnVawx9+qnvQt8l968txUGrlmtBc8
         WHJ93ef49P42ENvr+j91DC9W3uRbaJVrrez1r+dKDRRzRkezrP6KuCg8k/GbxaIoQGVB
         sJAw==
X-Gm-Message-State: APjAAAXabPyZXuEWeMc8c55/+YvjL1cE6K6rgnZVq6Y3O2Q53kp2eKN8
        fS82tZpsTqtff+tm0dHyF2qjlcy58G9Hw+IIuK6ecqI1lSzssasVuVcykvzIfca+D448l2UgKav
        N60IpJDQCoxAWclUxzgJLe8sQ5x2RPdhV4e+DZPjnBw==
X-Received: by 2002:a2e:a41b:: with SMTP id p27mr19601408ljn.104.1570475634275;
        Mon, 07 Oct 2019 12:13:54 -0700 (PDT)
X-Google-Smtp-Source: APXvYqybsfi5mH8tF9NrZD7sU22hacx7Zua94Z8/UMHxu/hlrhN5z+2JdKI5u1YfWM3R1sWLFJpjLuPHGGU6Fb/5yKU=
X-Received: by 2002:a2e:a41b:: with SMTP id p27mr19601397ljn.104.1570475634102;
 Mon, 07 Oct 2019 12:13:54 -0700 (PDT)
MIME-Version: 1.0
From:   Yizhuo Zhai <yzhai003@ucr.edu>
Date:   Mon, 7 Oct 2019 12:14:37 -0700
Message-ID: <CABvMjLRtWPgMKR8t758DZ1AhynWC4LxG8bTVxiNGF4OJgtNsbg@mail.gmail.com>
Subject: Potential NULL pointer deference in iwlwifi
To:     Johannes Berg <johannes.berg@intel.com>,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>,
        Intel Linux Wireless <linuxwifi@intel.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Haim Dreyfuss <haim.dreyfuss@intel.com>,
        Avigail Grinstein <avigail.grinstein@intel.com>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Zhiyun Qian <zhiyunq@cs.ucr.edu>,
        Chengyu Song <csong@cs.ucr.edu>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All:

drivers/net/wireless/intel/iwlwifi/mvm/power.c:

Inside function iwl_mvm_power_ps_disabled_iterator(),
iwl_mvm_vif_from_mac80211()
could return NULL,however, the return value of
iwl_mvm_vif_from_mac80211() is not
checked and get
used. This could potentially be unsafe.

-- 
Kind Regards,

Yizhuo Zhai

Computer Science, Graduate Student
University of California, Riverside
