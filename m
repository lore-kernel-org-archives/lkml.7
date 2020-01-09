Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B8B7C32771
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 07:14:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7D592072A
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 07:14:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728271AbgAIHO1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 02:14:27 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:41106 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726541AbgAIHO0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 02:14:26 -0500
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 8F2BCD8059C7DC9A87A0;
        Thu,  9 Jan 2020 15:14:22 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.204) with Microsoft SMTP Server (TLS) id 14.3.439.0; Thu, 9 Jan 2020
 15:14:21 +0800
Subject: Re: [f2fs-dev][PATCH] resize.f2fs: add option for large_nat_bitmap
 feature
To:     =?UTF-8?B?UGluZzEgWGlvbmcg54aK5bmz?= <xiongping1@xiaomi.com>,
        "linux-f2fs-devel@lists.sourceforge.net" 
        <linux-f2fs-devel@lists.sourceforge.net>,
        "jaegeuk@kernel.org" <jaegeuk@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <1578482416650.67283@xiaomi.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <d48d8d65-1308-278c-db86-0806a0c3637a@huawei.com>
Date:   Thu, 9 Jan 2020 15:14:20 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1578482416650.67283@xiaomi.com>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/1/8 19:20, Ping1 Xiong 熊平 wrote:
> ​From d5b8411dbae37180c37d96bf164fab16138fc21a Mon Sep 17 00:00:00 2001
> 
> From: xiongping1 <xiongping1@xiaomi.com>
> Date: Wed, 8 Jan 2020 17:20:55 +0800
> Subject: [PATCH] resize.f2fs: add option for large_nat_bitmap feature

Thanks for your contribution.

The patch format is incorrect, I guess it was changed by email client or when
you paste patch's content, could you check it?

> 
> resize.f2fs has already supported large_nat_bitmap feature, but has no
> option to turn on it.
> 
> This change add a new '-i' option to control turning on/off it.

We only add a option to turn on this feature, right? rather than turning
on or off it?

Thanks,

> 
> Signed-off-by: xiongping1 <xiongping1@xiaomi.com>
> ---
>  fsck/main.c   | 6 +++++-
>  fsck/resize.c | 5 +++++
>  2 files changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/fsck/main.c b/fsck/main.c
> index 9a7d499..e7e3dfc 100644
> --- a/fsck/main.c
> +++ b/fsck/main.c
> @@ -104,6 +104,7 @@ void resize_usage()
>          MSG(0, "\nUsage: resize.f2fs [options] device\n");
>          MSG(0, "[options]:\n");
>          MSG(0, "  -d debug level [default:0]\n");
> +       MSG(0, "  -i extended node bitmap, node ratio is 20%% by default\n");
>          MSG(0, "  -s safe resize (Does not resize metadata)");
>          MSG(0, "  -t target sectors [default: device size]\n");
>          MSG(0, "  -V print the version number and exit\n");
> @@ -449,7 +450,7 @@ void f2fs_parse_options(int argc, char *argv[])
>                                  break;
>                  }
>          } else if (!strcmp("resize.f2fs", prog)) {
> -               const char *option_string = "d:st:V";
> +               const char *option_string = "d:st:iV";
>  
>                  c.func = RESIZE;
>                  while ((option = getopt(argc, argv, option_string)) != EOF) {
> @@ -476,6 +477,9 @@ void f2fs_parse_options(int argc, char *argv[])
>                                          ret = sscanf(optarg, "%"PRIx64"",
>                                                          &c.target_sectors);
>                                  break;
> +                       case 'i':
> +                               c.large_nat_bitmap = 1;
> +                               break;
>                          case 'V':
>                                  show_version(prog);
>                                  exit(0);
> diff --git a/fsck/resize.c b/fsck/resize.c
> index fc563f2..88e063e 100644
> --- a/fsck/resize.c
> +++ b/fsck/resize.c
> @@ -519,6 +519,11 @@ static void rebuild_checkpoint(struct f2fs_sb_info *sbi,
>          else
>                  set_cp(checksum_offset, CP_CHKSUM_OFFSET);
>  
> +       if (c.large_nat_bitmap) {
> +               set_cp(checksum_offset, CP_MIN_CHKSUM_OFFSET);
> +               flags |= CP_LARGE_NAT_BITMAP_FLAG;
> +       }
> +
>          set_cp(ckpt_flags, flags);
>  
>          memcpy(new_cp, cp, (unsigned char *)cp->sit_nat_version_bitmap -
> -- 
> 2.7.4
> 
> ​
> 
> 
> #/******本邮件及其附件含有小米公司的保密信息，仅限于发送给上面地址中列出的个人或群组。禁止任何其他人以任何形式使用（包括但不限于全部或部分地泄露、复制、或散发）本邮件中的信息。如果您错收了本邮件，请您立即电话或邮件通知发件人并删除本邮件！ This e-mail and its attachments contain confidential information from XIAOMI, which is intended only for the person or entity whose address is listed above. Any use of the information contained herein in any way (including, but not limited to, total or partial disclosure, reproduction, or dissemination) by persons other than the intended recipient(s) is prohibited. If you receive this e-mail in error, please notify the sender by phone or email immediately and delete it!******/#
