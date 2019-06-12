Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3144C31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 07:38:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59F7A20866
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 07:38:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560325080;
	bh=rtnME8TEhnpeHX4nv+iYTiKYufnNCzELoLcv/WWLofc=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=Uz2oTJpUZIRbypVsWcn/XoWUHozanXrNJhM8QX+2g9sT1DzA8LHelVsaLw1Dc9Lfk
	 3Op77aHgzfzXp9+P6ei1QpyZB8JGHphHvW7IYipG3jlovHxK60cTlbwyIkBzm9OB3G
	 kZ2/4csPVvocMG7GIQQUIHsTNi9amk0Gp1BfPLbY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731545AbfFLHh7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 03:37:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:38778 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726778AbfFLHh6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 03:37:58 -0400
Received: from sol.localdomain (c-24-5-143-220.hsd1.ca.comcast.net [24.5.143.220])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 186302080A;
        Wed, 12 Jun 2019 07:37:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560325074;
        bh=rtnME8TEhnpeHX4nv+iYTiKYufnNCzELoLcv/WWLofc=;
        h=Date:From:To:Cc:Subject:From;
        b=yDXloKCLEnTewq3/PcqsseRM6k1A6dVj2gPK9quJ+BePJJHv0W8AwmRenN/pbLHcF
         RRADkG/+wOV0Tj3Totl5izx2I3ouYayJNNqLjRuQZbhNMClxVlTi+/rJn9JC2eoBzp
         Zr6sLYGiEWg+C6j/1lZLXb6oU/hM5ryWk3NY7IWE=
Date:   Wed, 12 Jun 2019 00:37:52 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     syzkaller <syzkaller@googlegroups.com>
Cc:     syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        linux-kernel@vger.kernel.org
Subject: Open syzbot reports by kernel subsystem
Message-ID: <20190612073752.GA30429@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To make some sense of the huge number of open syzbot reports against the kernel
(https://syzkaller.appspot.com/upstream), I assigned a tentative kernel
subsystem(s) to most reports.  I also wrote a script that assigns the reports
priorities based on some heuristics -- e.g. how recently it occurred, type of
reproducer, whether it happened in mainline, keywords in crash signature.

I personally find this really useful for my own use already.  But in case it's
useful for other people too, I've listed all open bug reports below in order
from highest to lowest heuristic priority within each subsystem.

Ideally this sort of thing would be natively supported by syzbot itself, so
people don't have to dig through 500 bugs to find the ones in "their" subsystem,
or to find the ones to focus on fixing first.

I think that some kernel maintainers would also find reminders by subsystem
really helpful.  For now I might send some out manually myself...

Just some ideas...

Subsystem(s)         Repro    Last seen      Mainline    Title
--------------------------------------------------------------------------------------------------------------

android/ashmem       C        49 days ago    yes         WARNING in __vm_enough_memory

android/binder       syz      10 days ago    yes         WARNING in binder_transaction_buffer_release

block                C        10 days ago    yes         KASAN: use-after-free Read in debugfs_remove (3)
block                C        1 days ago     yes         WARNING in blk_mq_sched_free_requests
block                C        1 days ago     yes         WARNING in generic_make_request_checks
block                C        4 days ago     yes         WARNING in md_ioctl
block                         1 days ago     yes         KASAN: use-after-free Read in relay_switch_subbuf
block                C        188 days ago   yes         KMSAN: kernel-infoleak in copy_page_to_iter (2)
block                         96 days ago    yes         KASAN: use-after-free Read in disk_map_sector_rcu
block                         58 days ago    yes         general protection fault in debugfs_remove
block                         47 days ago    yes         general protection fault in relay_close_buf
block                         138 days ago   yes         general protection fault in relay_switch_subbuf

bluetooth            C        2 days ago     yes         KASAN: use-after-free Read in kfree_skb (3)
bluetooth            C        1 days ago     yes         WARNING: refcount bug in kobject_get
bluetooth            C        2 days ago     yes         general protection fault in skb_put
bluetooth            C        1 days ago     yes         BUG: MAX_LOCKDEP_CHAIN_HLOCKS too low!
bluetooth            C        1 days ago     yes         WARNING in tty_set_termios
bluetooth            C        5 days ago     yes         general protection fault in kernfs_add_one
bluetooth            C        1 days ago     yes         WARNING in kernfs_get
bluetooth            C        10 days ago    yes         memory leak in get_device_parent
bluetooth            C        18 days ago    yes         memory leak in bcsp_recv
bluetooth            C        158 days ago   yes         KASAN: use-after-free Write in hci_sock_release
bluetooth            C        41 days ago    yes         KASAN: slab-out-of-bounds Read in bacpy
bluetooth            C        34 days ago    yes         WARNING: ODEBUG bug in rfcomm_dlc_free
bluetooth            C        82 days ago    yes         BUG: unable to handle kernel NULL pointer dereference in hci_uart_set_flow_control
bluetooth            C        45 days ago    yes         KMSAN: uninit-value in hci_event_packet
bluetooth                     4 days ago     yes         KASAN: use-after-free Read in rfcomm_dlc_exists
bluetooth            C        120 days ago   yes         general protection fault in qca_setup
bluetooth            C        155 days ago   yes         KASAN: slab-out-of-bounds Read in hci_event_packet
bluetooth                     39 days ago    yes         KASAN: use-after-free Read in hci_cmd_timeout
bluetooth                     22 days ago                KASAN: use-after-free Read in rfcomm_dlc_open (2)
bluetooth                     175 days ago   yes         KASAN: use-after-free Read in kernfs_put
bluetooth                     40 days ago                general protection fault in rfcomm_dlc_open
bluetooth                     40 days ago                general protection fault in rfcomm_dlc_exists
bluetooth                     57 days ago    yes         WARNING in kernfs_activate
bluetooth                     54 days ago    yes         INFO: trying to register non-static key in hci_uart_send_frame
bluetooth                     86 days ago    yes         WARNING in lockdep_register_key
bluetooth                     115 days ago   yes         WARNING: ODEBUG bug in hci_uart_tty_close
bluetooth                     119 days ago               general protection fault in idr_remove
bluetooth                     121 days ago   yes         INFO: trying to register non-static key in hci_uart_flush

crypto               C        3 days ago     yes         INFO: task hung in aead_recvmsg

fs/9p                C        7 days ago     yes         memory leak in v9fs_cache_session_get_cookie
fs/9p                syz      41 days ago    yes         WARNING: refcount bug in p9_req_put
fs/9p                C        303 days ago   yes         KASAN: use-after-free Read in p9_fd_poll
fs/9p                C        300 days ago   yes         KASAN: use-after-free Read in ep_scan_ready_list
fs/9p                C        299 days ago   yes         KASAN: use-after-free Read in p9_conn_cancel
fs/9p                C        298 days ago   yes         KASAN: use-after-free Read in __queue_work (2)
fs/9p                C        43 days ago    yes         INFO: task hung in iterate_supers
fs/9p                C        40 days ago    yes         INFO: task hung in flush_work
fs/9p                syz      62 days ago    yes         BUG: corrupted list in p9_read_work (2)
fs/9p                C        315 days ago               KASAN: use-after-free Read in generic_perform_write
fs/9p                C        317 days ago   yes         general protection fault in p9_conn_cancel
fs/9p                C        336 days ago   yes         KMSAN: uninit-value in unix_find_other
fs/9p                C        334 days ago   yes         KMSAN: uninit-value in p9_client_rpc
fs/9p                C        298 days ago   yes         WARNING: ODEBUG bug in p9_fd_close
fs/9p                C        260 days ago   yes         BUG: corrupted list in p9_write_work
fs/9p                C        237 days ago   yes         BUG: corrupted list in p9_conn_cancel
fs/9p                C        258 days ago               general protection fault in p9_client_prepare_req
fs/9p                syz      330 days ago               general protection fault in do_raw_spin_unlock

fs/bfs               C        437 days ago   yes         KASAN: slab-out-of-bounds Read in find_first_zero_bit

fs/btrfs                      3 days ago     yes         kernel BUG at fs/btrfs/volumes.c:LINE!
fs/btrfs                      40 days ago    yes         invalid opcode in close_fs_devices
fs/btrfs                      129 days ago   yes         general protection fault in btrfs_scan_one_device

fs/ext4,kernel/perf  C        4 days ago     yes         INFO: rcu detected stall in ext4_file_write_iter
fs/ext4,kernel/perf  C        4 days ago     yes         INFO: rcu detected stall in sys_sendfile64 (2)
fs/ext4              C        1 days ago     yes         WARNING in ext4_set_page_dirty
fs/ext4              C        98 days ago    yes         possible deadlock in __generic_file_fsync
fs/ext4              C        168 days ago   yes         possible deadlock in flush_workqueue (2)
fs/ext4                       44 days ago    yes         KASAN: use-after-free Read in ext4_xattr_set_entry (2)
fs/ext4                       44 days ago    yes         general protection fault in ext4_mb_initialize_context
fs/ext4                       55 days ago    yes         KASAN: slab-out-of-bounds Write in __ext4_expand_extra_isize
fs/ext4                       143 days ago   yes         KASAN: use-after-free Read in ext4_data_block_valid
fs/ext4                       128 days ago   yes         INFO: task hung in ext4_file_write_iter
fs/ext4                       107 days ago   yes         WARNING in ext4_dio_get_block_overwrite

fs/fat                        2 days ago     yes         kernel BUG at fs/buffer.c:LINE!

fs/fuse              C        2 days ago     yes         possible deadlock in free_ioctx_users
fs/fuse              C        39 days ago    yes         WARNING in __device_add_disk
fs/fuse              C        312 days ago   yes         KASAN: slab-out-of-bounds Write in end_requests
fs/fuse              C        224 days ago   yes         WARNING in request_end
fs/fuse              C        311 days ago   yes         INFO: task hung in fuse_reverse_inval_entry
fs/fuse              C        153 days ago               WARNING in ep_poll_callback

fs/gfs2              C        437 days ago   yes         WARNING in account_page_dirtied

fs/hfs               C        394 days ago   yes         general protection fault in hfs_find_init
fs/hfs               C        435 days ago   yes         kernel BUG at fs/hfs/inode.c:LINE!
fs/hfs               C        434 days ago   yes         WARNING in hfs_bnode_create
fs/hfs               C        417 days ago   yes         possible deadlock in hfs_find_init

fs/nfs               C        1 days ago     yes         memory leak in nfs_get_client

fs/ntfs              C        433 days ago   yes         KASAN: use-after-free Read in ntfs_read_locked_inode
fs/ntfs                       1 days ago     yes         WARNING: bad unlock balance in rcu_core
fs/ntfs              C        435 days ago   yes         KASAN: slab-out-of-bounds Read in ntfs_attr_find
fs/ntfs              C        418 days ago   yes         kernel BUG at fs/ntfs/aops.c:LINE!

fs/overlayfs         C        9 days ago     yes         possible deadlock in mnt_want_write
fs/overlayfs         C        45 days ago    yes         WARNING in ovl_rename
fs/overlayfs         C        35 days ago    yes         possible deadlock in pipe_lock (2)
fs/overlayfs         C        44 days ago    yes         possible deadlock in path_openat
fs/overlayfs                  6 days ago     yes         possible deadlock in seq_read (2)
fs/overlayfs                  17 days ago    yes         possible deadlock in lookup_slow
fs/overlayfs                  25 days ago    yes         possible deadlock in lock_trace (2)
fs/overlayfs                  49 days ago    yes         possible deadlock in do_io_accounting (2)

fs/reiserfs          C        170 days ago   yes         KASAN: use-after-free Read in blkdev_get
fs/reiserfs          C        382 days ago   yes         BUG: unable to handle kernel paging request in cleanup_bitmap_list
fs/reiserfs          syz      417 days ago   yes         kernel BUG at fs/reiserfs/journal.c:LINE!
fs/reiserfs          C        418 days ago   yes         WARNING in unlock_new_inode
fs/reiserfs                   50 days ago    yes         kernel BUG at fs/reiserfs/lock.c:LINE!

fs/xfs               C        113 days ago   yes         INFO: task hung in xlog_grant_head_check

gpu                  C        1 days ago     yes         WARNING in vkms_vblank_simulate

hid                  syz      4 days ago     yes         INFO: task hung in fsnotify_connector_destroy_workfn (2)

input                syz      231 days ago   yes         INFO: task hung in evdev_release

isdn                 C        1 days ago     yes         KMSAN: uninit-value in capi_write
isdn                          126 days ago   yes         KASAN: use-after-free Read in dev_expire_timer
isdn                          102 days ago   yes         BUG: spinlock bad magic in flush_workqueue_prep_pwqs

kernel               C        0 days ago     yes         BUG: MAX_STACK_TRACE_ENTRIES too low! (2)
kernel               C        33 days ago                WARNING in cgroup_exit
kernel               syz      89 days ago    yes         KASAN: out-of-bounds Read in unwind_next_frame
kernel               C        97 days ago    yes         WARNING in task_participate_group_stop (2)
kernel                        54 days ago    yes         WARNING in lockdep_unregister_key (2)

kernel/cgroup        C        7 days ago     yes         WARNING in cgroup_apply_control_enable
kernel/cgroup        C        2 days ago                 KASAN: slab-out-of-bounds Read in css_task_iter_advance
kernel/cgroup                 1 days ago                 KASAN: use-after-free Read in css_task_iter_advance

kernel/exec          C        188 days ago   yes         WARNING: syz-executor still has locks held!

fs/ext4,kernel/perf  C        4 days ago     yes         INFO: rcu detected stall in ext4_file_write_iter
fs/ext4,kernel/perf  C        4 days ago     yes         INFO: rcu detected stall in sys_sendfile64 (2)
kernel/perf          C        2 days ago     yes         WARNING in perf_group_attach
kernel/perf          C        2 days ago     yes         INFO: task hung in __do_page_fault (2)
kernel/perf          syz      3 days ago     yes         INFO: task hung in do_exit
kernel/perf          C        100 days ago   yes         KASAN: use-after-free Write in _free_event
kernel/perf          syz      54 days ago    yes         KASAN: use-after-free Read in refcount_sub_and_test_checked (2)
kernel/perf          C        39 days ago    yes         KASAN: stack-out-of-bounds Read in update_stack_state
kernel/perf          C        80 days ago    yes         WARNING in arch_install_hw_breakpoint
kernel/perf                   1 days ago     yes         general protection fault in perf_tp_event
kernel/perf          syz      53 days ago    yes         WARNING: ODEBUG bug in __do_softirq
kernel/perf          C        116 days ago   yes         KASAN: use-after-free Read in uprobe_perf_close
kernel/perf                   1 days ago     yes         WARNING in tracepoint_probe_register_prio (3)
kernel/perf          syz      61 days ago    yes         INFO: rcu detected stall in __perf_sw_event
kernel/perf          C        244 days ago   yes         WARNING in event_function_local
kernel/perf                   64 days ago    yes         INFO: task hung in uprobe_start_dup_mmap
kernel/perf                   177 days ago   yes         possible deadlock in perf_trace_destroy (3)
kernel/perf                   152 days ago   yes         possible deadlock in percpu_down_write
kernel/perf                   144 days ago   yes         possible deadlock in uprobe_clear_state

kvm                  C        51 days ago    yes         KASAN: use-after-free Read in do_general_protection
kvm                  C        9 days ago     yes         unexpected kernel reboot (3)
kvm                  C        95 days ago    yes         KASAN: use-after-free Read in __schedule (2)
kvm                  C        263 days ago   yes         KASAN: use-after-free Write in preempt_notifier_register (2)
kvm                  syz      100 days ago   yes         BUG: unable to handle kernel paging request in mmu_page_zap_pte
kvm                  C        98 days ago    yes         KMSAN: uninit-value in vmx_queue_exception
kvm                  syz      45 days ago    yes         BUG: soft lockup in kvm_vm_ioctl
kvm                  syz      189 days ago   yes         KASAN: use-after-free Read in kvm_write_guest_offset_cached
kvm                  syz      95 days ago                BUG: unable to handle kernel paging request in __kvm_mmu_prepare_zap_page
kvm                  C        312 days ago   yes         BUG: unable to handle kernel paging request in vmx_vcpu_run
kvm                  syz      54 days ago    yes         WARNING in kvm_arch_vcpu_ioctl_run (3)
kvm                  syz      44 days ago    yes         INFO: rcu detected stall in kvm_vcpu_ioctl
kvm                  C        261 days ago   yes         general protection fault in __schedule (2)
kvm                  syz      187 days ago   yes         general protection fault in kvm_pv_send_ipi
kvm                  C        153 days ago   yes         WARNING in mmu_spte_clear_track_bits (2)
kvm                  C        234 days ago   yes         BUG: sleeping function called from invalid context at arch/x86/mm/fault.c:LINE (2)
kvm                  syz      218 days ago   yes         BUG: spinlock cpu recursion on CPU, syz-executor
kvm                  syz      118 days ago   yes         BUG: soft lockup in kvm_vm_release
kvm                  C        507 days ago   yes         WARNING in x86_emulate_insn
kvm                  C        319 days ago   yes         WARNING: kernel stack regs has bad value (2)
kvm                  syz      275 days ago   yes         INFO: rcu detected stall in vcpu_enter_guest
kvm                           56 days ago    yes         BUG: unable to handle kernel paging request in init_srcu_struct_fields
kvm                  C        308 days ago               WARNING in kvm_set_tsc_khz
kvm                           95 days ago                kernel BUG at arch/x86/kvm/x86.c:LINE! (3)
kvm                           143 days ago   yes         WARNING in _cleanup_srcu_struct
kvm                           106 days ago   yes         WARNING: kernel stack regs has bad 'bp' value (4)

loop                 C        39 days ago    yes         WARNING in notify_change
loop                 C        190 days ago   yes         WARNING in mark_buffer_dirty

media                C        1 days ago     yes         KASAN: use-after-free Read in v4l2_release
usb,media            C        1 days ago     yes         general protection fault in flexcop_usb_probe
media                C        5 days ago     yes         KASAN: use-after-free Read in v4l2_fh_init
media                C        1 days ago     yes         WARNING in __vb2_queue_cancel
media                C        9 days ago     yes         KASAN: null-ptr-deref Read in refcount_sub_and_test_checked (2)
media                C        10 days ago    yes         KASAN: use-after-free Read in v4l2_ioctl
usb,media            C        2 days ago     yes         KMSAN: uninit-value in sd_init
media                C        3 days ago     yes         WARNING in vb2_core_reqbufs
usb,media            C        1 days ago     yes         WARNING in __flush_work (3)
usb,media            C        1 days ago     yes         WARNING in spi_register_controller
media                C        6 days ago     yes         KASAN: slab-out-of-bounds Read in technisat_usb2_rc_query
media,usb            C        5 days ago     yes         INFO: trying to register non-static key in mxl111sf_ctrl_msg
media                C        222 days ago   yes         KASAN: use-after-free Write in __vb2_cleanup_fileio
media                syz      94 days ago    yes         BUG: unable to handle kernel paging request in tpg_fill_plane_buffer
usb,media                     2 days ago     yes         BUG: unable to handle kernel paging request in au0828_usb_disconnect
media                C        168 days ago   yes         general protection fault in vb2_mmap
media                         10 days ago    yes         KASAN: use-after-free Write in v4l2_prio_close
media                         6 days ago     yes         KASAN: use-after-free Read in __video_do_ioctl
media                         33 days ago    yes         KASAN: use-after-free Write in v4l2_device_release
media                C        222 days ago   yes         INFO: task hung in vivid_stop_generating_vid_cap
media                C        173 days ago   yes         WARNING in dma_buf_vunmap
media                C        168 days ago   yes         possible deadlock in v4l2_release
media                         42 days ago    yes         KASAN: use-after-free Read in v4l2_fh_del
media                         129 days ago   yes         divide error in vivid_thread_vid_cap

mm                   C        132 days ago               KASAN: null-ptr-deref Read in reclaim_high
mm                            9 days ago     yes         kernel BUG at mm/huge_memory.c:LINE!
mm                   syz      125 days ago   yes         WARNING in untrack_pfn
mm                            54 days ago    yes         WARNING: locking bug in split_huge_page_to_list
mm                            80 days ago    yes         kernel BUG at mm/internal.h:LINE!
mm                            66 days ago    yes         kernel BUG at mm/page_alloc.c:LINE!
mm                            131 days ago   yes         possible deadlock in userfaultfd_ctx_read

mm/shmem                      49 days ago    yes         KASAN: use-after-free Read in shmem_fault

vfs,mm/userfaultfd   C        1 days ago     yes         possible deadlock in io_submit_one
vfs/aio,mm/userfaultfd C        26 days ago    yes         possible deadlock in userfaultfd_release
mm/userfaultfd       C        130 days ago   yes         possible deadlock in aio_poll

usb,net              C        1 days ago     yes         KASAN: use-after-free Read in usb_kill_anchored_urbs
net                  C        1 days ago     yes         memory leak in nf_hook_entries_grow
net                  C        1 days ago     yes         KMSAN: uninit-value in bcmp
usb,net              C        1 days ago     yes         KMSAN: uninit-value in ax88772_bind
net                  C        0 days ago     yes         KMSAN: uninit-value in bond_start_xmit (2)
net                  C        2 days ago     yes         memory leak in start_sync_thread
net                  C        1 days ago     yes         BUG: Bad rss-counter state (3)
net                  C        0 days ago     yes         kernel BUG at net/core/skbuff.c:LINE! (3)
net                  C        3 days ago     yes         KMSAN: uninit-value in ip6_parse_tlv
net                  C        0 days ago     yes         unregister_netdevice: waiting for DEV to become free (2)
usb,net              C        0 days ago     yes         WARNING in rollback_registered_many (2)
net                  syz      1 days ago     yes         INFO: trying to register non-static key in __icmp_send
net                  C        76 days ago    yes         KASAN: use-after-free Write in skb_release_data (2)
net                  syz      1 days ago                 general protection fault in ip6_dst_lookup_tail (2)
net                  syz      58 days ago    yes         WARNING: refcount bug in igmp_start_timer
net                  C        17 days ago    yes         INFO: task hung in addrconf_dad_work
net                  syz      11 days ago    yes         WARNING in xt_compat_add_offset
net                  syz      22 days ago    yes         WARNING: ODEBUG bug in del_timer (3)
net                           2 days ago     yes         KASAN: use-after-free Read in tcp_sk_exit
net                  C        52 days ago    yes         KMSAN: uninit-value in do_ip_vs_set_ctl
net                  C        45 days ago    yes         KMSAN: uninit-value in __dev_mc_del
net                  C        43 days ago    yes         KMSAN: uninit-value in __netif_receive_skb_core
net                  C        39 days ago    yes         WARNING: locking bug in lock_sock_nested
net                           1 days ago     yes         KASAN: null-ptr-deref Read in ip6_hold_safe
net                  C        149 days ago   yes         KASAN: use-after-free Read in tick_sched_handle (3)
net                  C        98 days ago    yes         KMSAN: uninit-value in gre_rcv (2)
net                  C        62 days ago    yes         KMSAN: uninit-value in __dev_mc_add
net                           5 days ago     yes         KASAN: use-after-free Read in ila_nf_input
net                           2 days ago     yes         general protection fault in gro_cells_destroy
net                           2 days ago     yes         KASAN: slab-out-of-bounds Read in ip6_hold_safe
net                           2 days ago                 kernel panic: stack is corrupted in __lock_acquire (4)
net                           5 days ago     yes         general protection fault in rt_cache_valid
net                           3 days ago     yes         kernel BUG at net/ipv6/route.c:LINE! (2)
net                  syz      77 days ago    yes         WARNING: bad unlock balance detected! (3)
net                  C        359 days ago   yes         KMSAN: uninit-value in IP6_ECN_decapsulate
net                  C        280 days ago   yes         KMSAN: uninit-value in strlcpy (2)
net                  C        204 days ago   yes         KMSAN: uninit-value in ip_rcv_core
net                  C        198 days ago   yes         KASAN: slab-out-of-bounds Read in ip6_tnl_parse_tlv_enc_lim
net                  C        197 days ago               KASAN: out-of-bounds in update_curr
net                  C        188 days ago   yes         KMSAN: uninit-value in sit_tunnel_xmit
net                  C        114 days ago   yes         INFO: task hung in rtnetlink_rcv_msg
net                  C        142 days ago   yes         kernel BUG at net/ipv4/ip_output.c:LINE!
net                           11 days ago    yes         KASAN: slab-out-of-bounds Read in tcp_sk_exit
net                           10 days ago    yes         KASAN: user-memory-access Write in dst_release
net                           4 days ago     yes         INFO: task hung in unregister_netdevice_notifier (3)
net                           11 days ago                KASAN: null-ptr-deref Write in dst_release
net                  C        434 days ago   yes         possible deadlock in sch_direct_xmit
net                  C        416 days ago   yes         INFO: task hung in do_ip_vs_set_ctl (2)
net                  C        406 days ago   yes         WARNING in tcp_enter_loss (2)
net                  C        296 days ago   yes         inconsistent lock state in ila_xlat_nl_cmd_del_mapping
net                           13 days ago                BUG: unable to handle kernel paging request in dst_dev_put
net                  syz      296 days ago   yes         inconsistent lock state in ila_xlat_nl_cmd_add_mapping
net                  syz      201 days ago   yes         WARNING in csum_and_copy_to_iter
net                  syz      112 days ago   yes         INFO: trying to register non-static key in icmp_send
net                           13 days ago                general protection fault in __sock_release (2)
net                           11 days ago                KASAN: slab-out-of-bounds Read in fib6_rule_lookup (2)
net                           9 days ago                 KASAN: slab-out-of-bounds Read in fib6_purge_rt (2)
net                           2 days ago                 general protection fault in fib6_purge_rt (2)
net                           2 days ago                 general protection fault in dev_get_by_index_rcu
net                           33 days ago    yes         KASAN: slab-out-of-bounds Read in page_get_anon_vma
net                           98 days ago    yes         KASAN: use-after-free Read in icmp_sk_exit
net                  C        169 days ago               possible deadlock in neigh_change_state
net                           3 days ago                 general protection fault in fib6_nh_init
net                           3 days ago                 general protection fault in tcp_v6_connect
net                           44 days ago                KASAN: wild-memory-access Write in fib6_purge_rt
net                           31 days ago                general protection fault in ipv6_rcv
net                           2 days ago                 KASAN: user-memory-access Write in fib6_purge_rt (2)
net                  syz      119 days ago               WARNING: locking bug in try_to_grab_pending
net                           23 days ago    yes         possible deadlock in sk_diag_fill
net                           23 days ago    yes         possible deadlock in bond_get_stats (2)
net                           97 days ago    yes         general protection fault in __queue_work
net                           72 days ago                KASAN: use-after-free Read in ip_tunnel_lookup
net                           99 days ago    yes         KASAN: slab-out-of-bounds Read in ip_send_unicast_reply
net                           7 days ago                 KASAN: slab-out-of-bounds Read in icmpv6_xrlim_allow
net                           3 days ago                 WARNING: locking bug in udpv6_pre_connect
net                           3 days ago                 WARNING: locking bug in icmp6_send (2)
net                           77 days ago    yes         BUG: spinlock bad magic in __queue_work
net                           48 days ago    yes         WARNING in remove_proc_entry (2)
net                           38 days ago    yes         WARNING in __static_key_slow_dec_cpuslocked
net                           89 days ago                general protection fault in ip6_dst_hoplimit
net                           141 days ago               KASAN: use-after-free Read in do_raw_spin_trylock
net                           92 days ago    yes         possible deadlock in genl_rcv (2)
net                           83 days ago    yes         possible deadlock in skb_queue_tail
net                           55 days ago                INFO: rcu detected stall in gc_worker
net                           52 days ago                WARNING in fib6_add (2)
net                           104 days ago   yes         KASAN: slab-out-of-bounds Read in dst_dev_put
net                           88 days ago                possible deadlock in dev_uc_sync_multiple
net                           75 days ago                possible deadlock in __dev_queue_xmit (2)

net/ax25                      1 days ago     yes         general protection fault in ax25_send_frame
net/ax25             syz      48 days ago    yes         KASAN: stack-out-of-bounds Write in ax25_getname
net/ax25                      155 days ago               general protection fault in ax25_send_control
net/ax25                      81 days ago                inconsistent lock state in ax25_std_heartbeat_expiry

net/batman-adv       C        1 days ago     yes         memory leak in batadv_tvlv_handler_register

net/bpf              syz      1 days ago     yes         KASAN: use-after-free Read in sk_psock_unlink
net/bpf              C        1 days ago     yes         WARNING in bpf_jit_free
net/bpf              syz      3 days ago     yes         BUG: unable to handle kernel paging request in bpf_prog_kallsyms_add
net/bpf              syz      1 days ago     yes         KASAN: slab-out-of-bounds Read in class_equal
net/bpf              C        1 days ago     yes         WARNING: kernel stack frame pointer has bad value (2)
net/bpf              syz      4 days ago     yes         KASAN: slab-out-of-bounds Read in usage_accumulate
net/bpf              syz      1 days ago     yes         WARNING in bpf_prog_kallsyms_find
net/bpf              syz      7 days ago     yes         general protection fault in rb_erase (2)
net/bpf              syz      6 days ago     yes         KASAN: slab-out-of-bounds Read in corrupted (2)
net/bpf              syz      40 days ago    yes         KASAN: use-after-free Read in bpf_prog_kallsyms_add
net/bpf              syz      12 days ago    yes         memory leak in sock_hash_update_common
net/bpf              syz      4 days ago                 general protection fault in mm_update_next_owner
net/bpf              C        231 days ago   yes         KASAN: use-after-free Read in psock_map_pop
net/bpf              syz      161 days ago   yes         KASAN: use-after-free Read in bpf_prog_kallsyms_del
net/bpf              C        324 days ago   yes         general protection fault in smap_list_hash_remove
net/bpf              C        291 days ago   yes         general protection fault in bpf_tcp_close (2)
net/bpf              C        316 days ago   yes         KASAN: slab-out-of-bounds Read in sock_hash_ctx_update_elem
net/bpf              syz      130 days ago               BUG: unable to handle kernel paging request in bpf_prog_kallsyms_find
net/bpf              C        264 days ago   yes         WARNING: suspicious RCU usage in trace_call_bpf
net/bpf              syz      159 days ago   yes         WARNING in bpf_prog_kallsyms_add
net/bpf                       13 days ago                WARNING in bpf_base_func_proto
net/bpf                       44 days ago                INFO: rcu detected stall in sys_bpf

net/dccp             C        32 days ago    yes         KASAN: use-after-free Read in ccid2_hc_tx_packet_recv
net/dccp             C        25 days ago    yes         KASAN: use-after-free Read in ccid_hc_tx_delete
net/dccp             C        31 days ago    yes         BUG: please report to dccp@vger.kernel.org => prev = 0, last = 0 at net/dccp/ccids/lib/packet_history.c:LINE/tfrc_rx_hist_sample_rtt()
net/dccp             C        417 days ago   yes         KMSAN: uninit-value in dccp_invalid_packet
net/dccp             C        493 days ago   yes         suspicious RCU usage at ./include/net/inet_sock.h:LINE
net/dccp             C        260 days ago   yes         WARNING: suspicious RCU usage in pid_task

net/hsr              C        1 days ago     yes         KMSAN: uninit-value in hsr_register_frame_in
net/hsr              C        1 days ago     yes         WARNING in hsr_forward_skb
net/hsr              C        1 days ago     yes         WARNING in hsr_addr_subst_dest
net/hsr              C        6 days ago     yes         memory leak in hsr_create_self_node
net/hsr                       58 days ago                BUG: corrupted list in hsr_prune_nodes

net/kcm              C        1 days ago     yes         KMSAN: uninit-value in ip_tunnel_xmit (2)
net/kcm              C        2 days ago     yes         memory leak in rawv6_sendmsg
net/kcm              C        140 days ago   yes         general protection fault in skb_unlink
net/kcm              syz      377 days ago   yes         general protection fault in requeue_rx_msgs

net/l2tp             syz      2 days ago     yes         WARNING: locking bug in do_ipv6_setsockopt
net/l2tp             syz      6 days ago     yes         WARNING: locking bug in inet_autobind

net/llc              C        1 days ago     yes         memory leak in llc_conn_ac_send_sabme_cmd_p_set_x
net/llc              C        1 days ago     yes         memory leak in llc_ui_sendmsg

net/netrom           C        1 days ago     yes         general protection fault in prepare_to_wait
net/netrom           syz      10 days ago    yes         KASAN: use-after-free Read in lock_sock_nested
net/netrom           C        11 days ago    yes         memory leak in nr_create
net/netrom           C        15 days ago    yes         memory leak in nr_rx_frame
net/netrom           syz      55 days ago    yes         KASAN: use-after-free Read in refcount_inc_not_zero_checked (2)
net/netrom           syz      13 days ago    yes         memory leak in nr_loopback_queue
net/netrom                    5 days ago                 KASAN: use-after-free Read in nr_release

net/pfkey                     126 days ago   yes         WARNING in pfkey_sock_destruct

net/ppp              syz      1 days ago     yes         memory leak in pppoe_sendmsg

net/rdma             syz      1 days ago     yes         KASAN: use-after-free Read in rdma_listen (2)
net/rdma             C        2 days ago     yes         WARNING: bad unlock balance in ucma_event_handler
net/rdma             C        94 days ago    yes         KASAN: use-after-free Read in cma_cancel_operation
net/rdma             syz      68 days ago    yes         general protection fault in rdma_listen (2)
net/rdma             C        436 days ago   yes         KASAN: use-after-free Read in __list_del_entry_valid (4)
net/rdma             C        93 days ago    yes         BUG: corrupted list in rdma_listen
net/rdma             syz      112 days ago   yes         KASAN: use-after-free Read in addr_handler
net/rdma             syz      80 days ago    yes         WARNING: bad unlock balance in ucma_destroy_id
net/rdma                      82 days ago    yes         KASAN: use-after-free Read in addr_resolve
net/rdma                      69 days ago                KASAN: use-after-free Read in rdma_bind_addr
net/rdma                      105 days ago   yes         KASAN: slab-out-of-bounds Read in rdma_listen

net/rds              C        2 days ago     yes         general protection fault in rds_recv_rcvbuf_delta
net/rds                       71 days ago    yes         KASAN: use-after-free Read in rds_cong_queue_updates (2)
net/rds                       68 days ago    yes         KASAN: slab-out-of-bounds Read in rds_cong_queue_updates (2)

net/rose             C        1 days ago     yes         general protection fault in rose_send_frame
net/rose                      10 days ago                INFO: rcu detected stall in rose_connect
net/rose                      5 days ago                 INFO: rcu detected stall in rose_loopback_timer (2)

net/rxrpc            C        22 days ago    yes         general protection fault in rxrpc_connect_call
net/rxrpc                     19 days ago    yes         WARNING: locking bug in flush_workqueue_prep_pwqs

net/sctp             C        2 days ago     yes         memory leak in sctp_stream_init_ext
net/sctp             C        6 days ago     yes         memory leak in sctp_get_port_local
net/sctp             C        11 days ago    yes         memory leak in sctp_send_reset_streams
net/sctp             C        10 days ago    yes         memory leak in sctp_v6_create_accept_sk
net/sctp             syz      57 days ago    yes         KASAN: use-after-free Read in __lock_sock
net/sctp             C        89 days ago                general protection fault in sctp_sched_dequeue_common (2)
net/sctp                      10 days ago    yes         KASAN: slab-out-of-bounds Read in rt_cache_valid
net/sctp                      4 days ago                 KASAN: use-after-free Read in ip6_hold_safe (3)
net/sctp                      1 days ago                 KASAN: user-memory-access Read in ip6_hold_safe (3)
net/sctp                      6 days ago                 BUG: unable to handle kernel paging request in sctp_v6_get_dst
net/sctp                      5 days ago                 general protection fault in sctp_v6_get_dst (2)
net/sctp                      78 days ago                BUG: unable to handle kernel paging request in dst_release (2)
net/sctp                      57 days ago                KASAN: slab-out-of-bounds Read in fib6_rule_action
net/sctp                      116 days ago               general protection fault in reuseport_add_sock

net/smc              C        1 days ago     yes         WARNING in smc_unhash_sk (2)
net/smc              C        1 days ago     yes         WARNING: ODEBUG bug in __sk_destruct
net/smc              C        174 days ago   yes         general protection fault in inet_accept
net/smc              syz      147 days ago   yes         general protection fault in __smc_diag_dump

net/strparser        syz      121 days ago   yes         WARNING in strp_done (2)

net/sunrpc                    27 days ago                linux-next test error: WARNING in remove_proc_entry

net/tipc             C        1 days ago     yes         general protection fault in dst_dev_put (2)
net/tipc             syz      4 days ago     yes         KASAN: use-after-free Read in rt_cache_valid
net/tipc             C        2 days ago     yes         memory leak in tipc_buf_acquire
net/tipc             syz      1 days ago     yes         INFO: task hung in genl_rcv_msg
net/tipc             syz      2 days ago     yes         INFO: task hung in ctrl_getfamily
net/tipc             C        10 days ago    yes         WARNING: locking bug in __queue_work
net/tipc             C        21 days ago    yes         KASAN: slab-out-of-bounds Read in rhashtable_walk_enter
net/tipc             C        21 days ago    yes         BUG: spinlock bad magic in rhashtable_walk_enter
net/tipc             syz      5 days ago     yes         KMSAN: uninit-value in __tipc_nl_bearer_enable
net/tipc             C        21 days ago    yes         WARNING: locking bug in rhashtable_walk_enter
net/tipc             C        92 days ago    yes         general protection fault in __bfs (2)
net/tipc             C        15 days ago    yes         INFO: task hung in netdev_run_todo
net/tipc             syz      34 days ago    yes         KASAN: slab-out-of-bounds Read in ip_append_data
net/tipc             syz      182 days ago   yes         inconsistent lock state in icmp_send
net/tipc                      2 days ago                 BUG: unable to handle kernel paging request in iptunnel_xmit
net/tipc                      24 days ago                general protection fault in rhashtable_walk_enter
net/tipc                      25 days ago                BUG: corrupted list in proto_register
net/tipc                      173 days ago               general protection fault in ip6_route_output_flags
net/tipc                      146 days ago               INFO: rcu detected stall in tipc_disc_timeout
net/tipc                      126 days ago               INFO: task hung in tipc_bcast_stop

net/tls              C        1 days ago     yes         KASAN: use-after-free Read in tls_write_space
net/tls              C        1 days ago     yes         kernel BUG at include/linux/scatterlist.h:LINE!
net/tls              C        1 days ago     yes         KMSAN: uninit-value in gf128mul_4k_lle (3)
net/tls              C        2 days ago     yes         INFO: task hung in tls_sw_free_resources_tx
net/tls              C        1 days ago     yes         INFO: task hung in __flush_work
net/tls              C        4 days ago     yes         WARNING in sk_stream_kill_queues (3)
net/tls              syz      4 days ago     yes         memory leak in create_ctx
net/tls              C        29 days ago    yes         kernel BUG at include/linux/mm.h:LINE! (5)
net/tls              C        152 days ago   yes         KASAN: use-after-free Read in crypto_gcm_init_common
net/tls              C        133 days ago   yes         KASAN: use-after-free Read in generic_gcmaes_encrypt
net/tls              syz      263 days ago   yes         general protection fault in tcp_cleanup_ulp
net/tls              C        259 days ago               KASAN: slab-out-of-bounds Read in tls_write_space
net/tls                       2 days ago                 KASAN: use-after-free Read in timer_is_static_object (2)
net/tls                       25 days ago                KASAN: use-after-free Read in tls_push_sg
net/tls                       20 days ago    yes         WARNING: ODEBUG bug in tls_sw_free_resources_tx
net/tls                       31 days ago                INFO: task hung in tls_sw_sendmsg

usb,net/wireless     C        1 days ago     yes         general protection fault in ath6kl_usb_alloc_urb_from_pipe
usb,net/wireless     C        1 days ago     yes         KMSAN: uninit-value in rt2500usb_bbp_read
net/wireless         C        2 days ago     yes         memory leak in kobject_set_name_vargs
usb,net/wireless     C        1 days ago     yes         WARNING: ODEBUG bug in rsi_probe
usb,net/wireless     C        1 days ago     yes         WARNING in ar5523_submit_rx_cmd/usb_submit_urb
usb,net/wireless     C        1 days ago     yes         WARNING: ath10k USB support is incomplete, don't expect anything to work!
usb,net/wireless     C        1 days ago     yes         INFO: trying to register non-static key in del_timer_sync (2)
usb,net/wireless     C        1 days ago     yes         WARNING in zd_mac_clear
usb,net/wireless     C        0 days ago     yes         INFO: trying to register non-static key in rtl_c2hcmd_launcher
usb,net/wireless     C        3 days ago     yes         WARNING in submit_rx_urb/usb_submit_urb

net/x25              C        2 days ago     yes         memory leak in lapb_register
net/x25                       1 days ago                 KASAN: null-ptr-deref Read in x25_connect
net/x25                       18 days ago                general protection fault in refcount_sub_and_test_checked
net/x25                       3 days ago                 general protection fault in x25_connect
net/x25                       112 days ago               KASAN: use-after-free Read in x25_write_internal
net/x25                       110 days ago               INFO: rcu detected stall in x25_connect

net/xfrm             C        63 days ago    yes         general protection fault in get_work_pool
net/xfrm             C        438 days ago   yes         KASAN: use-after-free Read in _decode_session4
net/xfrm             C        210 days ago   yes         KASAN: use-after-free Read in _decode_session6
net/xfrm             C        203 days ago   yes         KASAN: slab-out-of-bounds Read in _decode_session6 (2)
net/xfrm             syz      40 days ago    yes         WARNING in xfrm_policy_fini
net/xfrm             C        83 days ago                WARNING: suspicious RCU usage in xfrm_get_sadinfo
net/xfrm             C        83 days ago                WARNING: suspicious RCU usage in xfrm_get_spdinfo
net/xfrm             C        83 days ago                WARNING: suspicious RCU usage in xfrm_alloc_userspi
net/xfrm             C        226 days ago   yes         KMSAN: uninit-value in _decode_session6
net/xfrm             C        156 days ago   yes         KMSAN: uninit-value in xfrm_state_find
net/xfrm             C        152 days ago   yes         KMSAN: uninit-value in _decode_session4
net/xfrm             C        133 days ago   yes         KASAN: stack-out-of-bounds Read in xfrm_state_find (5)
net/xfrm                      33 days ago                KASAN: use-after-free Write in xfrm_hash_rebuild
net/xfrm                      30 days ago                KASAN: use-after-free Write in __xfrm_policy_unlink (2)
net/xfrm             syz      84 days ago                WARNING: suspicious RCU usage in xfrm_get_policy
net/xfrm             syz      453 days ago               general protection fault in xfrm_init_replay
net/xfrm             C        197 days ago   yes         WARNING in xfrm_policy_insert
net/xfrm                      11 days ago    yes         WARNING in __vunmap
net/xfrm                      11 days ago    yes         INFO: rcu detected stall in pppol2tp_sendmsg
net/xfrm                      18 days ago    yes         INFO: rcu detected stall in igmp_ifc_timer_expire
net/xfrm                      57 days ago                KASAN: use-after-free Read in xfrm_sk_policy_lookup (2)
net/xfrm                      59 days ago                general protection fault in xfrm_lookup_with_ifid
net/xfrm                      116 days ago   yes         general protection fault in __vunmap
net/xfrm                      155 days ago               general protection fault in ipcomp_init_state
net/xfrm                      106 days ago               general protection fault in __xfrm_policy_check
net/xfrm                      103 days ago               general protection fault in xfrmi_rcv_cb
net/xfrm                      133 days ago               INFO: rcu detected stall in inet_dgram_connect

rtc                  C        2 days ago     yes         BUG: workqueue lockup (4)

security/apparmor    C        35 days ago    yes         INFO: rcu detected stall in rw_verify_area

security/ima         C        8 days ago                 possible deadlock in get_user_pages_unlocked (2)
security/ima         C        8 days ago     yes         possible deadlock in process_measurement
security/ima         C        91 days ago    yes         INFO: task hung in process_measurement
security/ima         C        7 days ago                 possible deadlock in __do_page_fault (2)

security/smack       syz      240 days ago   yes         possible deadlock in ext4_evict_inode

security/tomoyo      syz      7 days ago     yes         KASAN: use-after-free Read in tomoyo_realpath_from_path
security/tomoyo               15 days ago                KASAN: invalid-free in tomoyo_realpath_from_path

sound                C        16 days ago    yes         WARNING: proc registration bug in snd_info_card_register
sound,usb            syz      4 days ago     yes         WARNING in snd_usb_motu_microbookii_communicate/usb_submit_urb
sound                C        107 days ago   yes         KASAN: slab-out-of-bounds Write in default_read_copy_kernel
sound                syz      45 days ago    yes         INFO: rcu detected stall in snd_seq_write
sound                         42 days ago    yes         KASAN: use-after-free Write in check_and_subscribe_port
sound                         89 days ago    yes         KASAN: use-after-free Read in wake_up_if_idle
sound                         16 days ago    yes         WARNING: suspicious RCU usage in line6_pcm_acquire
sound                         168 days ago   yes         KASAN: use-after-free Read in delete_and_unsubscribe_port
sound                         58 days ago                KASAN: slab-out-of-bounds Read in linear_transfer (2)
sound                         83 days ago    yes         INFO: task hung in snd_seq_write

tty                  C        0 days ago     yes         possible deadlock in console_unlock
tty                  C        47 days ago    yes         BUG: unable to handle kernel paging request in slhc_free
tty                  syz      7 days ago     yes         memory leak in cfserl_create

unknown              C        10 days ago    yes         memory leak in proc_register
unknown              C        35 days ago    yes         possible deadlock in down_trylock (2)
unknown              syz      55 days ago    yes         BUG: unable to handle kernel paging request in free_block (5)
unknown                       2 days ago     yes         KASAN: use-after-free Read in blkcg_print_stat
unknown                       9 days ago                 linux-next boot error: WARNING: workqueue cpumask: online intersect > possible intersect
unknown                       1 days ago     yes         BUG: MAX_LOCKDEP_CHAINS too low!
unknown              C        233 days ago   yes         kernel BUG at fs/block_dev.c:LINE!
unknown              C        79 days ago    yes         INFO: rcu detected stall in do_idle
unknown                       1 days ago     yes         possible deadlock in userfaultfd_read (2)
unknown              C        261 days ago   yes         general protection fault in finish_task_switch (2)
unknown                       17 days ago    yes         KASAN: use-after-free Read in dst_dev_put
unknown              C        162 days ago   yes         WARNING in enqueue_task_dl
unknown              C        109 days ago   yes         WARNING in rcu_check_gp_start_stall
unknown              syz      172 days ago   yes         general protection fault in put_pid
unknown              C        334 days ago   yes         BUG: MAX_LOCK_DEPTH too low! (2)
unknown              C        334 days ago               general protection fault in propagate_entity_cfs_rq
unknown              syz      149 days ago   yes         BUG: unable to handle kernel NULL pointer dereference in __do_softirq
unknown              C        283 days ago   yes         WARNING: suspicious RCU usage (4)
unknown                       2 days ago                 KASAN: use-after-free Read in register_shrinker_prepared
unknown                       7 days ago     yes         WARNING in cleanup_mnt
unknown                       2 days ago                 WARNING: refcount bug in css_task_iter_next
unknown              syz      191 days ago   yes         WARNING in blkdev_put
unknown                       62 days ago    yes         KASAN: use-after-free Read in page_get_anon_vma
unknown                       33 days ago    yes         INFO: rcu detected stall in try_check_zero
unknown                       45 days ago    yes         WARNING in zap_class
unknown                       85 days ago    yes         kernel BUG at include/linux/page-flags.h:LINE!
unknown                       77 days ago    yes         possible deadlock in static_key_slow_dec
unknown                       63 days ago    yes         INFO: task hung in __x64_sys_io_destroy
unknown                       176 days ago   yes         KASAN: slab-out-of-bounds Read in perf_exclude_event
unknown                       149 days ago   yes         BUG: Bad page map (3)
unknown                       177 days ago   yes         INFO: task hung in vfs_setxattr
unknown                       172 days ago   yes         possible deadlock in ep_free
unknown                       165 days ago   yes         inconsistent lock state in fs_reclaim_acquire (2)
unknown                       161 days ago   yes         WARNING in handle_irq (3)
unknown                       157 days ago   yes         possible deadlock in fs_reclaim_acquire
unknown                       148 days ago   yes         possible deadlock in try_to_wake_up
unknown                       148 days ago   yes         INFO: task hung in sock_ioctl

usb,net              C        1 days ago     yes         KASAN: use-after-free Read in usb_kill_anchored_urbs
usb                  C        1 days ago     yes         general protection fault in device_del (3)
usb,net/wireless     C        1 days ago     yes         general protection fault in ath6kl_usb_alloc_urb_from_pipe
usb,media            C        1 days ago     yes         general protection fault in flexcop_usb_probe
usb                  C        1 days ago     yes         KMSAN: uninit-value in r871xu_drv_init
usb,net/wireless     C        1 days ago     yes         KMSAN: uninit-value in rt2500usb_bbp_read
usb,net              C        1 days ago     yes         KMSAN: uninit-value in ax88772_bind
usb,net/wireless     C        1 days ago     yes         WARNING: ODEBUG bug in rsi_probe
usb,media            C        2 days ago     yes         KMSAN: uninit-value in sd_init
usb                  C        3 days ago     yes         KMSAN: uninit-value in mii_nway_restart
usb                  C        16 days ago    yes         KASAN: use-after-free Read in ds_probe
usb,net/wireless     C        1 days ago     yes         WARNING in ar5523_submit_rx_cmd/usb_submit_urb
usb,net/wireless     C        1 days ago     yes         WARNING: ath10k USB support is incomplete, don't expect anything to work!
usb,media            C        1 days ago     yes         WARNING in __flush_work (3)
usb,net/wireless     C        1 days ago     yes         INFO: trying to register non-static key in del_timer_sync (2)
usb,media            C        1 days ago     yes         WARNING in spi_register_controller
usb                  C        1 days ago     yes         possible deadlock in mon_bin_vma_fault
usb,net/wireless     C        1 days ago     yes         WARNING in zd_mac_clear
usb,net/wireless     C        0 days ago     yes         INFO: trying to register non-static key in rtl_c2hcmd_launcher
usb,net              C        0 days ago     yes         WARNING in rollback_registered_many (2)
usb                  C        6 days ago     yes         general protection fault in cdev_del
usb                  syz      8 days ago     yes         KASAN: use-after-free Read in p54u_load_firmware_cb
usb                  C        8 days ago     yes         KASAN: stack-out-of-bounds Read in hfcsusb_probe
usb                  C        6 days ago     yes         KMSAN: uninit-value in read_sensor_register
usb                  C        6 days ago     yes         KASAN: invalid-free in rsi_91x_deinit
usb,net/wireless     C        3 days ago     yes         WARNING in submit_rx_urb/usb_submit_urb
usb                  C        9 days ago     yes         KMSAN: uninit-value in i2c_w
media,usb            C        5 days ago     yes         INFO: trying to register non-static key in mxl111sf_ctrl_msg
usb                  C        6 days ago     yes         WARNING in aiptek_open/usb_submit_urb
sound,usb            syz      4 days ago     yes         WARNING in snd_usb_motu_microbookii_communicate/usb_submit_urb
usb                  syz      31 days ago    yes         general protection fault in drain_workqueue
usb                  C        41 days ago    yes         KASAN: global-out-of-bounds Read in hdpvr_probe
usb,media                     2 days ago     yes         BUG: unable to handle kernel paging request in au0828_usb_disconnect
usb                  syz      17 days ago    yes         INFO: trying to register non-static key in usbtouch_reset_resume
usb                  C        236 days ago   yes         KASAN: use-after-free Read in vhci_hub_control
usb                           10 days ago    yes         KASAN: use-after-free Read in device_del
usb                  syz      44 days ago    yes         KASAN: slab-out-of-bounds Read in hex_string
usb                           7 days ago     yes         KMSAN: uninit-value in ax88178_bind
usb                           13 days ago    yes         general protection fault in usb_gadget_udc_reset (2)
usb                           12 days ago    yes         KASAN: slab-out-of-bounds Read in p54u_load_firmware_cb
usb                           50 days ago    yes         BUG: unable to handle kernel paging request in osq_lock
usb                           33 days ago    yes         INFO: task hung in usb_bulk_msg

vfs                  C        2 days ago     yes         KASAN: use-after-free Read in mntput
vfs,mm/userfaultfd   C        1 days ago     yes         possible deadlock in io_submit_one
vfs                  C        63 days ago                general protection fault in d_alloc_pseudo
vfs                           4 days ago     yes         BUG: Dentry still in use [unmount of tmpfs tmpfs]
vfs                  C        142 days ago   yes         INFO: task hung in lock_mount
vfs                           93 days ago                KASAN: use-after-free Read in d_walk
vfs                           57 days ago    yes         INFO: task hung in __ia32_sys_io_uring_enter
vfs                           51 days ago    yes         INFO: task hung in __x64_sys_io_uring_enter

vfs/aio,mm/userfaultfd C        26 days ago    yes         possible deadlock in userfaultfd_release

vfs/io_uring         C        1 days ago     yes         memory leak in new_inode_pseudo

vhost                C        3 days ago     yes         memory leak in vhost_net_ioctl
vhost                         105 days ago   yes         INFO: task hung in vhost_init_device_iotlb


... and if I rank all reports together, these are the highest-priority reports
currently:

vfs                  C        2 days ago     yes         KASAN: use-after-free Read in mntput
vfs,mm/userfaultfd   C        1 days ago     yes         possible deadlock in io_submit_one 
bluetooth            C        2 days ago     yes         KASAN: use-after-free Read in kfree_skb (3) 
kernel               C        0 days ago     yes         BUG: MAX_STACK_TRACE_ENTRIES too low! (2) 
media                C        1 days ago     yes         KASAN: use-after-free Read in v4l2_release 
net/tls              C        1 days ago     yes         KASAN: use-after-free Read in tls_write_space 
usb,net              C        1 days ago     yes         KASAN: use-after-free Read in usb_kill_anchored_urbs 
net/rose             C        1 days ago     yes         general protection fault in rose_send_frame 
net/netrom           C        1 days ago     yes         general protection fault in prepare_to_wait 
net/tipc             C        1 days ago     yes         general protection fault in dst_dev_put (2) 
vfs/io_uring         C        1 days ago     yes         memory leak in new_inode_pseudo 
bluetooth            C        1 days ago     yes         WARNING: refcount bug in kobject_get 
