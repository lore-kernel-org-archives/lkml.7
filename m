Return-Path: <SRS0=3QRk=U6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEF96C0650F
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 07:55:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C798120652
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 07:55:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727535AbfGAHzQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 03:55:16 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:7685 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726036AbfGAHzQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 03:55:16 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 2D3EDC673DAA50F06FFE;
        Mon,  1 Jul 2019 15:55:12 +0800 (CST)
Received: from [127.0.0.1] (10.65.94.163) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.439.0; Mon, 1 Jul 2019
 15:55:05 +0800
Subject: Re: linux-next: build failure after merge of the rdma tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
CC:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        Lijun Ou <oulijun@huawei.com>
References: <20190701141431.5cba95c3@canb.auug.org.au>
From:   wangxi <wangxi11@huawei.com>
Message-ID: <bbd5fbc9-2dac-ae1b-7cae-68790b6ea878@huawei.com>
Date:   Mon, 1 Jul 2019 15:54:30 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20190701141431.5cba95c3@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.65.94.163]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2019/7/1 12:14, Stephen Rothwell 写道:
> Hi all,
> 
> After merging the rdma tree, today's linux-next build (x86_64
> allmodconfig) failed like this:
> 
> WARNING: modpost: missing MODULE_LICENSE() in drivers/infiniband/hw/hns/hns_roce_ah.o
> see include/linux/module.h for more information
> WARNING: modpost: missing MODULE_LICENSE() in drivers/infiniband/hw/hns/hns_roce_alloc.o
> see include/linux/module.h for more information
> WARNING: modpost: missing MODULE_LICENSE() in drivers/infiniband/hw/hns/hns_roce_cmd.o
> see include/linux/module.h for more information
> WARNING: modpost: missing MODULE_LICENSE() in drivers/infiniband/hw/hns/hns_roce_cq.o
> see include/linux/module.h for more information
> WARNING: modpost: missing MODULE_LICENSE() in drivers/infiniband/hw/hns/hns_roce_db.o
> see include/linux/module.h for more information
> WARNING: modpost: missing MODULE_LICENSE() in drivers/infiniband/hw/hns/hns_roce_hem.o
> see include/linux/module.h for more information
> WARNING: modpost: missing MODULE_LICENSE() in drivers/infiniband/hw/hns/hns_roce_mr.o
> see include/linux/module.h for more information
> WARNING: modpost: missing MODULE_LICENSE() in drivers/infiniband/hw/hns/hns_roce_pd.o
> see include/linux/module.h for more information
> WARNING: modpost: missing MODULE_LICENSE() in drivers/infiniband/hw/hns/hns_roce_qp.o
> see include/linux/module.h for more information
> WARNING: modpost: missing MODULE_LICENSE() in drivers/infiniband/hw/hns/hns_roce_restrack.o
> see include/linux/module.h for more information
> WARNING: modpost: missing MODULE_LICENSE() in drivers/infiniband/hw/hns/hns_roce_srq.o
> see include/linux/module.h for more information
> ERROR: "hns_roce_bitmap_cleanup" [drivers/infiniband/hw/hns/hns_roce_srq.ko] undefined!
> ERROR: "hns_roce_bitmap_init" [drivers/infiniband/hw/hns/hns_roce_srq.ko] undefined!
> ERROR: "hns_roce_free_cmd_mailbox" [drivers/infiniband/hw/hns/hns_roce_srq.ko] undefined!
> ERROR: "hns_roce_alloc_cmd_mailbox" [drivers/infiniband/hw/hns/hns_roce_srq.ko] undefined!
> ERROR: "hns_roce_table_get" [drivers/infiniband/hw/hns/hns_roce_srq.ko] undefined!
> ERROR: "hns_roce_bitmap_alloc" [drivers/infiniband/hw/hns/hns_roce_srq.ko] undefined!
> ERROR: "hns_roce_table_find" [drivers/infiniband/hw/hns/hns_roce_srq.ko] undefined!
> ERROR: "hns_roce_ib_umem_write_mtt" [drivers/infiniband/hw/hns/hns_roce_srq.ko] undefined!
> ERROR: "hns_roce_mtt_cleanup" [drivers/infiniband/hw/hns/hns_roce_srq.ko] undefined!
> ERROR: "hns_roce_buf_write_mtt" [drivers/infiniband/hw/hns/hns_roce_srq.ko] undefined!
> ERROR: "hns_roce_buf_free" [drivers/infiniband/hw/hns/hns_roce_srq.ko] undefined!
> ERROR: "hns_roce_buf_alloc" [drivers/infiniband/hw/hns/hns_roce_srq.ko] undefined!
> ERROR: "hns_roce_mtt_init" [drivers/infiniband/hw/hns/hns_roce_srq.ko] undefined!
> ERROR: "hns_roce_bitmap_free" [drivers/infiniband/hw/hns/hns_roce_srq.ko] undefined!
> ERROR: "hns_roce_table_put" [drivers/infiniband/hw/hns/hns_roce_srq.ko] undefined!
> ERROR: "hns_roce_cmd_mbox" [drivers/infiniband/hw/hns/hns_roce_srq.ko] undefined!
> ERROR: "hns_roce_bitmap_cleanup" [drivers/infiniband/hw/hns/hns_roce_qp.ko] undefined!
> ERROR: "hns_roce_bitmap_init" [drivers/infiniband/hw/hns/hns_roce_qp.ko] undefined!
> ERROR: "hns_roce_buf_free" [drivers/infiniband/hw/hns/hns_roce_qp.ko] undefined!
> ERROR: "hns_roce_free_db" [drivers/infiniband/hw/hns/hns_roce_qp.ko] undefined!
> ERROR: "hns_roce_alloc_db" [drivers/infiniband/hw/hns/hns_roce_qp.ko] undefined!
> ERROR: "hns_roce_bitmap_free_range" [drivers/infiniband/hw/hns/hns_roce_qp.ko] undefined!
> ERROR: "hns_roce_bitmap_alloc_range" [drivers/infiniband/hw/hns/hns_roce_qp.ko] undefined!
> ERROR: "hns_roce_db_unmap_user" [drivers/infiniband/hw/hns/hns_roce_qp.ko] undefined!
> ERROR: "hns_roce_mtr_cleanup" [drivers/infiniband/hw/hns/hns_roce_qp.ko] undefined!
> ERROR: "hns_roce_get_kmem_bufs" [drivers/infiniband/hw/hns/hns_roce_qp.ko] undefined!
> ERROR: "hns_roce_buf_alloc" [drivers/infiniband/hw/hns/hns_roce_qp.ko] undefined!
> ERROR: "hns_roce_db_map_user" [drivers/infiniband/hw/hns/hns_roce_qp.ko] undefined!
> ERROR: "hns_roce_free_buf_list" [drivers/infiniband/hw/hns/hns_roce_qp.ko] undefined!
> ERROR: "hns_roce_table_get" [drivers/infiniband/hw/hns/hns_roce_qp.ko] undefined!
> ERROR: "hns_roce_mtr_attach" [drivers/infiniband/hw/hns/hns_roce_qp.ko] undefined!
> ERROR: "hns_roce_mtr_init" [drivers/infiniband/hw/hns/hns_roce_qp.ko] undefined!
> ERROR: "hns_roce_hem_list_calc_root_ba" [drivers/infiniband/hw/hns/hns_roce_qp.ko] undefined!
> ERROR: "hns_roce_get_umem_bufs" [drivers/infiniband/hw/hns/hns_roce_qp.ko] undefined!
> ERROR: "hns_roce_alloc_buf_list" [drivers/infiniband/hw/hns/hns_roce_qp.ko] undefined!
> ERROR: "hns_roce_table_put" [drivers/infiniband/hw/hns/hns_roce_qp.ko] undefined!
> ERROR: "hns_roce_init_buf_region" [drivers/infiniband/hw/hns/hns_roce_qp.ko] undefined!
> ERROR: "hns_roce_bitmap_free" [drivers/infiniband/hw/hns/hns_roce_pd.ko] undefined!
> ERROR: "hns_roce_bitmap_alloc" [drivers/infiniband/hw/hns/hns_roce_pd.ko] undefined!
> ERROR: "hns_roce_bitmap_cleanup" [drivers/infiniband/hw/hns/hns_roce_pd.ko] undefined!
> ERROR: "hns_roce_bitmap_init" [drivers/infiniband/hw/hns/hns_roce_pd.ko] undefined!
> ERROR: "hns_roce_hem_list_find_mtt" [drivers/infiniband/hw/hns/hns_roce_mr.ko] undefined!
> ERROR: "hns_roce_hem_list_request" [drivers/infiniband/hw/hns/hns_roce_mr.ko] undefined!
> ERROR: "hns_roce_hem_list_release" [drivers/infiniband/hw/hns/hns_roce_mr.ko] undefined!
> ERROR: "hns_roce_hem_list_init" [drivers/infiniband/hw/hns/hns_roce_mr.ko] undefined!
> ERROR: "hns_roce_check_whether_mhop" [drivers/infiniband/hw/hns/hns_roce_mr.ko] undefined!
> ERROR: "hns_roce_bitmap_cleanup" [drivers/infiniband/hw/hns/hns_roce_mr.ko] undefined!
> ERROR: "hns_roce_bitmap_init" [drivers/infiniband/hw/hns/hns_roce_mr.ko] undefined!
> ERROR: "hns_roce_table_put_range" [drivers/infiniband/hw/hns/hns_roce_mr.ko] undefined!
> ERROR: "hns_roce_table_get_range" [drivers/infiniband/hw/hns/hns_roce_mr.ko] undefined!
> ERROR: "hns_roce_bitmap_alloc" [drivers/infiniband/hw/hns/hns_roce_mr.ko] undefined!
> ERROR: "hns_roce_table_find" [drivers/infiniband/hw/hns/hns_roce_mr.ko] undefined!
> ERROR: "hns_roce_bitmap_free" [drivers/infiniband/hw/hns/hns_roce_mr.ko] undefined!
> ERROR: "hns_roce_table_put" [drivers/infiniband/hw/hns/hns_roce_mr.ko] undefined!
> ERROR: "hns_roce_free_cmd_mailbox" [drivers/infiniband/hw/hns/hns_roce_mr.ko] undefined!
> ERROR: "hns_roce_cmd_mbox" [drivers/infiniband/hw/hns/hns_roce_mr.ko] undefined!
> ERROR: "hns_roce_alloc_cmd_mailbox" [drivers/infiniband/hw/hns/hns_roce_mr.ko] undefined!
> ERROR: "hns_roce_table_get" [drivers/infiniband/hw/hns/hns_roce_mr.ko] undefined!
> ERROR: "hns_roce_fill_res_entry" [drivers/infiniband/hw/hns/hns_roce_main.ko] undefined!
> ERROR: "hns_roce_dereg_mr" [drivers/infiniband/hw/hns/hns_roce_main.ko] undefined!
> ERROR: "hns_roce_reg_user_mr" [drivers/infiniband/hw/hns/hns_roce_main.ko] undefined!
> ERROR: "hns_roce_get_dma_mr" [drivers/infiniband/hw/hns/hns_roce_main.ko] undefined!
> ERROR: "hns_roce_ib_destroy_cq" [drivers/infiniband/hw/hns/hns_roce_main.ko] undefined!
> ERROR: "hns_roce_ib_create_cq" [drivers/infiniband/hw/hns/hns_roce_main.ko] undefined!
> ERROR: "hns_roce_modify_qp" [drivers/infiniband/hw/hns/hns_roce_main.ko] undefined!
> ERROR: "hns_roce_create_qp" [drivers/infiniband/hw/hns/hns_roce_main.ko] undefined!
> ERROR: "hns_roce_destroy_ah" [drivers/infiniband/hw/hns/hns_roce_main.ko] undefined!
> ERROR: "hns_roce_query_ah" [drivers/infiniband/hw/hns/hns_roce_main.ko] undefined!
> ERROR: "hns_roce_create_ah" [drivers/infiniband/hw/hns/hns_roce_main.ko] undefined!
> ERROR: "hns_roce_dealloc_pd" [drivers/infiniband/hw/hns/hns_roce_main.ko] undefined!
> ERROR: "hns_roce_alloc_pd" [drivers/infiniband/hw/hns/hns_roce_main.ko] undefined!
> ERROR: "hns_roce_rereg_user_mr" [drivers/infiniband/hw/hns/hns_roce_main.ko] undefined!
> ERROR: "hns_roce_dealloc_mw" [drivers/infiniband/hw/hns/hns_roce_main.ko] undefined!
> ERROR: "hns_roce_alloc_mw" [drivers/infiniband/hw/hns/hns_roce_main.ko] undefined!
> ERROR: "hns_roce_map_mr_sg" [drivers/infiniband/hw/hns/hns_roce_main.ko] undefined!
> ERROR: "hns_roce_alloc_mr" [drivers/infiniband/hw/hns/hns_roce_main.ko] undefined!
> ERROR: "hns_roce_destroy_srq" [drivers/infiniband/hw/hns/hns_roce_main.ko] undefined!
> ERROR: "hns_roce_create_srq" [drivers/infiniband/hw/hns/hns_roce_main.ko] undefined!
> ERROR: "hns_roce_cleanup_qp_table" [drivers/infiniband/hw/hns/hns_roce_main.ko] undefined!
> ERROR: "hns_roce_cleanup_uar_table" [drivers/infiniband/hw/hns/hns_roce_main.ko] undefined!
> ERROR: "hns_roce_cleanup_pd_table" [drivers/infiniband/hw/hns/hns_roce_main.ko] undefined!
> ERROR: "hns_roce_cleanup_mr_table" [drivers/infiniband/hw/hns/hns_roce_main.ko] undefined!
> ERROR: "hns_roce_cleanup_cq_table" [drivers/infiniband/hw/hns/hns_roce_main.ko] undefined!
> ERROR: "hns_roce_cleanup_hem_table" [drivers/infiniband/hw/hns/hns_roce_main.ko] undefined!
> ERROR: "hns_roce_cmd_use_polling" [drivers/infiniband/hw/hns/hns_roce_main.ko] undefined!
> ERROR: "hns_roce_init_srq_table" [drivers/infiniband/hw/hns/hns_roce_main.ko] undefined!
> ERROR: "hns_roce_cmd_cleanup" [drivers/infiniband/hw/hns/hns_roce_main.ko] undefined!
> ERROR: "hns_roce_cleanup_hem" [drivers/infiniband/hw/hns/hns_roce_main.ko] undefined!
> ERROR: "hns_roce_cleanup_bitmap" [drivers/infiniband/hw/hns/hns_roce_main.ko] undefined!
> ERROR: "hns_roce_cmd_use_events" [drivers/infiniband/hw/hns/hns_roce_main.ko] undefined!
> ERROR: "hns_roce_init_qp_table" [drivers/infiniband/hw/hns/hns_roce_main.ko] undefined!
> ERROR: "hns_roce_init_cq_table" [drivers/infiniband/hw/hns/hns_roce_main.ko] undefined!
> ERROR: "hns_roce_init_mr_table" [drivers/infiniband/hw/hns/hns_roce_main.ko] undefined!
> ERROR: "hns_roce_init_pd_table" [drivers/infiniband/hw/hns/hns_roce_main.ko] undefined!
> ERROR: "hns_roce_init_uar_table" [drivers/infiniband/hw/hns/hns_roce_main.ko] undefined!
> ERROR: "hns_roce_check_whether_mhop" [drivers/infiniband/hw/hns/hns_roce_main.ko] undefined!
> ERROR: "hns_roce_init_hem_table" [drivers/infiniband/hw/hns/hns_roce_main.ko] undefined!
> ERROR: "hns_roce_cmd_init" [drivers/infiniband/hw/hns/hns_roce_main.ko] undefined!
> ERROR: "hns_roce_uar_alloc" [drivers/infiniband/hw/hns/hns_roce_main.ko] undefined!
> ERROR: "hns_roce_uar_free" [drivers/infiniband/hw/hns/hns_roce_main.ko] undefined!
> ERROR: "hns_roce_bitmap_cleanup" [drivers/infiniband/hw/hns/hns_roce_cq.ko] undefined!
> ERROR: "hns_roce_bitmap_init" [drivers/infiniband/hw/hns/hns_roce_cq.ko] undefined!
> ERROR: "hns_roce_free_db" [drivers/infiniband/hw/hns/hns_roce_cq.ko] undefined!
> ERROR: "hns_roce_db_unmap_user" [drivers/infiniband/hw/hns/hns_roce_cq.ko] undefined!
> ERROR: "hns_roce_buf_free" [drivers/infiniband/hw/hns/hns_roce_cq.ko] undefined!
> ERROR: "hns_roce_mtt_cleanup" [drivers/infiniband/hw/hns/hns_roce_cq.ko] undefined!
> ERROR: "hns_roce_ib_umem_write_mtt" [drivers/infiniband/hw/hns/hns_roce_cq.ko] undefined!
> ERROR: "hns_roce_db_map_user" [drivers/infiniband/hw/hns/hns_roce_cq.ko] undefined!
> ERROR: "hns_roce_buf_write_mtt" [drivers/infiniband/hw/hns/hns_roce_cq.ko] undefined!
> ERROR: "hns_roce_buf_alloc" [drivers/infiniband/hw/hns/hns_roce_cq.ko] undefined!
> ERROR: "hns_roce_alloc_db" [drivers/infiniband/hw/hns/hns_roce_cq.ko] undefined!
> ERROR: "hns_roce_mtt_init" [drivers/infiniband/hw/hns/hns_roce_cq.ko] undefined!
> ERROR: "hns_roce_free_cmd_mailbox" [drivers/infiniband/hw/hns/hns_roce_cq.ko] undefined!
> ERROR: "hns_roce_alloc_cmd_mailbox" [drivers/infiniband/hw/hns/hns_roce_cq.ko] undefined!
> ERROR: "hns_roce_table_get" [drivers/infiniband/hw/hns/hns_roce_cq.ko] undefined!
> ERROR: "hns_roce_bitmap_alloc" [drivers/infiniband/hw/hns/hns_roce_cq.ko] undefined!
> ERROR: "hns_roce_table_find" [drivers/infiniband/hw/hns/hns_roce_cq.ko] undefined!
> ERROR: "hns_roce_check_whether_mhop" [drivers/infiniband/hw/hns/hns_roce_cq.ko] undefined!
> ERROR: "hns_roce_bitmap_free" [drivers/infiniband/hw/hns/hns_roce_cq.ko] undefined!
> ERROR: "hns_roce_table_put" [drivers/infiniband/hw/hns/hns_roce_cq.ko] undefined!
> ERROR: "hns_roce_cmd_mbox" [drivers/infiniband/hw/hns/hns_roce_cq.ko] undefined!
> ERROR: "hns_roce_cleanup_srq_table" [drivers/infiniband/hw/hns/hns_roce_alloc.ko] undefined!
> ERROR: "hns_roce_cleanup_uar_table" [drivers/infiniband/hw/hns/hns_roce_alloc.ko] undefined!
> ERROR: "hns_roce_cleanup_pd_table" [drivers/infiniband/hw/hns/hns_roce_alloc.ko] undefined!
> ERROR: "hns_roce_cleanup_mr_table" [drivers/infiniband/hw/hns/hns_roce_alloc.ko] undefined!
> ERROR: "hns_roce_cleanup_cq_table" [drivers/infiniband/hw/hns/hns_roce_alloc.ko] undefined!
> ERROR: "hns_roce_cleanup_qp_table" [drivers/infiniband/hw/hns/hns_roce_alloc.ko] undefined!
> ERROR: "to_hr_qp_type" [drivers/infiniband/hw/hns/hns-roce-hw-v1.ko] undefined!
> ERROR: "get_send_wqe" [drivers/infiniband/hw/hns/hns-roce-hw-v1.ko] undefined!
> ERROR: "hns_roce_release_range_qp" [drivers/infiniband/hw/hns/hns-roce-hw-v1.ko] undefined!
> ERROR: "hns_roce_mtt_cleanup" [drivers/infiniband/hw/hns/hns-roce-hw-v1.ko] undefined!
> ERROR: "hns_roce_cmd_mbox" [drivers/infiniband/hw/hns/hns-roce-hw-v1.ko] undefined!
> ERROR: "hns_roce_cmd_event" [drivers/infiniband/hw/hns/hns-roce-hw-v1.ko] undefined!
> ERROR: "hns_roce_cq_completion" [drivers/infiniband/hw/hns/hns-roce-hw-v1.ko] undefined!
> ERROR: "hns_roce_create_qp" [drivers/infiniband/hw/hns/hns-roce-hw-v1.ko] undefined!
> ERROR: "hns_roce_init" [drivers/infiniband/hw/hns/hns-roce-hw-v1.ko] undefined!
> ERROR: "hns_roce_buf_free" [drivers/infiniband/hw/hns/hns-roce-hw-v1.ko] undefined!
> ERROR: "hns_roce_free_cq" [drivers/infiniband/hw/hns/hns-roce-hw-v1.ko] undefined!
> ERROR: "hns_roce_hw2sw_mpt" [drivers/infiniband/hw/hns/hns-roce-hw-v1.ko] undefined!
> ERROR: "hns_get_gid_index" [drivers/infiniband/hw/hns/hns-roce-hw-v1.ko] undefined!
> ERROR: "hns_roce_dealloc_pd" [drivers/infiniband/hw/hns/hns-roce-hw-v1.ko] undefined!
> ERROR: "hns_roce_alloc_cmd_mailbox" [drivers/infiniband/hw/hns/hns-roce-hw-v1.ko] undefined!
> ERROR: "hns_roce_qp_remove" [drivers/infiniband/hw/hns/hns-roce-hw-v1.ko] undefined!
> ERROR: "hns_roce_alloc_pd" [drivers/infiniband/hw/hns/hns-roce-hw-v1.ko] undefined!
> ERROR: "hns_roce_free_cmd_mailbox" [drivers/infiniband/hw/hns/hns-roce-hw-v1.ko] undefined!
> ERROR: "get_recv_wqe" [drivers/infiniband/hw/hns/hns-roce-hw-v1.ko] undefined!
> ERROR: "hns_roce_unlock_cqs" [drivers/infiniband/hw/hns/hns-roce-hw-v1.ko] undefined!
> ERROR: "hns_roce_exit" [drivers/infiniband/hw/hns/hns-roce-hw-v1.ko] undefined!
> ERROR: "hns_roce_qp_event" [drivers/infiniband/hw/hns/hns-roce-hw-v1.ko] undefined!
> ERROR: "hns_roce_table_find" [drivers/infiniband/hw/hns/hns-roce-hw-v1.ko] undefined!
> ERROR: "to_hns_roce_state" [drivers/infiniband/hw/hns/hns-roce-hw-v1.ko] undefined!
> ERROR: "hns_roce_ib_create_cq" [drivers/infiniband/hw/hns/hns-roce-hw-v1.ko] undefined!
> ERROR: "hns_roce_cq_event" [drivers/infiniband/hw/hns/hns-roce-hw-v1.ko] undefined!
> ERROR: "hns_roce_qp_free" [drivers/infiniband/hw/hns/hns-roce-hw-v1.ko] undefined!
> ERROR: "hns_roce_lock_cqs" [drivers/infiniband/hw/hns/hns-roce-hw-v1.ko] undefined!
> ERROR: "hns_roce_wq_overflow" [drivers/infiniband/hw/hns/hns-roce-hw-v1.ko] undefined!
> ERROR: "key_to_hw_index" [drivers/infiniband/hw/hns/hns-roce-hw-v1.ko] undefined!
> ERROR: "hns_roce_bitmap_free" [drivers/infiniband/hw/hns/hns-roce-hw-v1.ko] undefined!
> ERROR: "hns_roce_ib_destroy_cq" [drivers/infiniband/hw/hns/hns-roce-hw-v1.ko] undefined!
> 
> Presumably caused by commit
> 
>   e9816ddf2a33 ("RDMA/hns: Cleanup unnecessary exported symbols")
> 
I have confirmed the latest code in https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git.
I found that the changes to Makefile and Kconfig in the original patch have been lost.

> I have used the rdma tree from next-20190628 for today.
> 

